import SwiftData
import SwiftUI

@main
struct CalmCampusApp: App {
    @State private var settings = AppSettings()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(settings)
                .environment(\.locale, settings.language.locale)
        }
        .modelContainer(for: WeeklyAnswer.self)
    }
}
