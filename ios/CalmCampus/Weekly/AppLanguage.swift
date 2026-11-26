import Foundation

enum AppLanguage: String, CaseIterable, Identifiable {
    case en, fr, nl

    var id: String { rawValue }

    /// Shown in its own language, whatever the app language is.
    var nativeName: String {
        switch self {
        case .en: "English"
        case .fr: "Français"
        case .nl: "Nederlands"
        }
    }

    var locale: Locale { Locale(identifier: rawValue) }

    /// First supported language in the device's preference list, otherwise English.
    static func fromDevice(preferred: [String] = Locale.preferredLanguages) -> AppLanguage {
        for tag in preferred {
            let code = Locale(identifier: tag).language.languageCode?.identifier ?? String(tag.prefix(2))
            if let match = AppLanguage(rawValue: code.lowercased()) { return match }
        }
        return .en
    }
}
