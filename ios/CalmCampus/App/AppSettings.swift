import Foundation
import Observation

/// Small on-device preferences, kept in UserDefaults. Nothing here is sent anywhere.
@Observable
final class AppSettings {
    private enum Key {
        static let language = "settings.language"
        static let institution = "settings.institution"
        static let welcomeSeen = "settings.welcomeSeen"
        static let reminder = "settings.reminder"
        static let all = [language, institution, welcomeSeen, reminder]
    }

    private let defaults: UserDefaults
    private let deviceLanguage: () -> AppLanguage

    /// nil means "follow the device".
    var languageOverride: AppLanguage? {
        didSet { defaults.set(languageOverride?.rawValue, forKey: Key.language) }
    }
    var institutionID: String? {
        didSet { defaults.set(institutionID, forKey: Key.institution) }
    }
    var welcomeSeen: Bool {
        didSet { defaults.set(welcomeSeen, forKey: Key.welcomeSeen) }
    }
    var reminderEnabled: Bool {
        didSet { defaults.set(reminderEnabled, forKey: Key.reminder) }
    }

    init(defaults: UserDefaults = .standard,
         deviceLanguage: @escaping () -> AppLanguage = { AppLanguage.fromDevice() }) {
        self.defaults = defaults
        self.deviceLanguage = deviceLanguage
        languageOverride = defaults.string(forKey: Key.language).flatMap(AppLanguage.init(rawValue:))
        institutionID = defaults.string(forKey: Key.institution)
        welcomeSeen = defaults.bool(forKey: Key.welcomeSeen)
        reminderEnabled = defaults.bool(forKey: Key.reminder)
    }

    var language: AppLanguage { languageOverride ?? deviceLanguage() }

    func text(_ key: S) -> String { key.text(language) }
    func text(_ key: S, _ args: CVarArg...) -> String {
        String(format: key.text(language), locale: language.locale, arguments: args)
    }

    /// Back to a fresh install: language follows the device, no institution, no reminder.
    /// The welcome screen is not shown again, so the student sees the "deleted" confirmation.
    func reset() {
        languageOverride = nil
        institutionID = nil
        reminderEnabled = false
        Key.all.forEach(defaults.removeObject(forKey:))
        defaults.set(welcomeSeen, forKey: Key.welcomeSeen)
    }
}
