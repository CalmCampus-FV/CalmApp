import SwiftUI

struct WelcomeView: View {
    @Environment(AppSettings.self) private var settings

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(settings.text(.welcomeLead)).font(.title3)
                    ForEach([S.welcomePoint1, .welcomePoint2, .welcomePoint3], id: \.self) { point in
                        Label(settings.text(point), systemImage: "checkmark")
                    }
                    LanguagePicker().pickerStyle(.menu)
                    Button(settings.text(.welcomeStart)) { settings.welcomeSeen = true }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                }
                .padding()
            }
            .navigationTitle(settings.text(.welcomeTitle))
        }
        .disclaimerFooter()
    }
}
