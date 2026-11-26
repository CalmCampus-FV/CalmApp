import SwiftData
import SwiftUI

struct AboutView: View {
    static let contactEmail = "contact@calm.braunf.com"

    @Environment(AppSettings.self) private var settings
    @Environment(\.modelContext) private var modelContext
    @Environment(\.openURL) private var openURL
    @State private var confirmDelete = false
    @State private var deleted = false
    @State private var reminderDenied = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text(settings.text(.aboutIntro))
                    Text(settings.text(.aboutCredit)).font(.footnote)
                }

                Section(settings.text(.languageHeading)) {
                    LanguagePicker().pickerStyle(.inline)
                }

                Section {
                    Toggle(settings.text(.reminderToggle), isOn: reminderBinding)
                    Text(settings.text(.reminderBody)).font(.footnote).foregroundStyle(.secondary)
                    if reminderDenied {
                        Text(settings.text(.reminderDenied)).font(.footnote)
                    }
                } header: { Text(settings.text(.reminderHeading)) }

                Section {
                    Text(settings.text(.privacyBody))
                } header: { Text(settings.text(.privacyHeading)) }

                Section {
                    Text(settings.text(.feedbackBody)).font(.footnote)
                    Button(settings.text(.feedbackButton), action: sendFeedback)
                } header: { Text(settings.text(.feedbackHeading)) }

                Section {
                    Text(settings.text(.deleteBody)).font(.footnote)
                    Button(settings.text(.deleteButton), role: .destructive) { confirmDelete = true }
                    if deleted { Text(settings.text(.deleteDone)).font(.footnote) }
                } header: { Text(settings.text(.deleteHeading)) }

                Section {
                    Text(settings.text(.version, appVersion)).font(.footnote).foregroundStyle(.secondary)
                }
            }
            .navigationTitle(settings.text(.aboutTitle))
            .confirmationDialog(settings.text(.deleteConfirm), isPresented: $confirmDelete, titleVisibility: .visible) {
                Button(settings.text(.deleteYes), role: .destructive, action: deleteEverything)
                Button(settings.text(.deleteCancel), role: .cancel) {}
            }
        }
        .disclaimerFooter()
    }

    private var appVersion: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0"
    }

    private var reminderBinding: Binding<Bool> {
        Binding(
            get: { settings.reminderEnabled },
            set: { on in
                if on {
                    Task {
                        let ok = await ReminderScheduler.enable(language: settings.language)
                        settings.reminderEnabled = ok
                        reminderDenied = !ok
                    }
                } else {
                    ReminderScheduler.disable()
                    settings.reminderEnabled = false
                    reminderDenied = false
                }
            })
    }

    private func sendFeedback() {
        var components = URLComponents()
        components.scheme = "mailto"
        components.path = Self.contactEmail
        components.queryItems = [
            URLQueryItem(name: "subject", value: settings.text(.feedbackSubject)),
            URLQueryItem(name: "body", value: settings.text(.feedbackTemplate)),
        ]
        if let url = components.url { openURL(url) }
    }

    private func deleteEverything() {
        try? modelContext.deleteAllWeeklyData()
        ReminderScheduler.disable()
        settings.reset()
        deleted = true
    }
}
