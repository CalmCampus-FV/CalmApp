import SwiftUI

struct RootView: View {
    enum Tab: Hashable { case checkin, weeks, support, about }

    @Environment(AppSettings.self) private var settings
    @State private var tab: Tab = .checkin

    var body: some View {
        if settings.welcomeSeen {
            TabView(selection: $tab) {
                CheckinHomeView(openSupport: { tab = .support })
                    .tabItem { Label(settings.text(.tabCheckin), systemImage: "checkmark.circle") }
                    .tag(Tab.checkin)
                HistoryView(openSupport: { tab = .support })
                    .tabItem { Label(settings.text(.tabWeeks), systemImage: "calendar") }
                    .tag(Tab.weeks)
                SupportView()
                    .tabItem { Label(settings.text(.tabSupport), systemImage: "heart.text.square") }
                    .tag(Tab.support)
                AboutView()
                    .tabItem { Label(settings.text(.tabAbout), systemImage: "info.circle") }
                    .tag(Tab.about)
            }
            .onChange(of: settings.language) { _, language in
                // Keep an existing reminder in the newly chosen language.
                guard settings.reminderEnabled else { return }
                Task { await ReminderScheduler.schedule(language: language) }
            }
        } else {
            WelcomeView()
        }
    }
}
