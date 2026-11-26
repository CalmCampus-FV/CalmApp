import Foundation

/// A string in the three app languages. `fr` is optional because the partner
/// service text we copied only exists in Dutch and English; French falls back to English.
struct LocalizedText: Equatable {
    let en: String
    let nl: String
    var fr: String? = nil

    func resolve(_ language: AppLanguage) -> String {
        switch language {
        case .en: en
        case .nl: nl
        case .fr: fr ?? en
        }
    }

    var allValues: [String] { [en, nl] + (fr.map { [$0] } ?? []) }
}

struct SupportService: Identifiable, Equatable {
    let id: String
    let name: LocalizedText
    let purpose: LocalizedText
    let note: LocalizedText?
    let link: LocalizedText?
    let email: String?
    let phone: String?
    let hours: LocalizedText?
}

struct EmergencyLine: Identifiable, Equatable {
    let id: String
    let number: String
    let tel: String
    let label: LocalizedText
    let detail: LocalizedText
}

struct Institution: Identifiable, Equatable {
    let id: String
    let name: LocalizedText
    let hint: LocalizedText?
    let advice: LocalizedText?
    let services: [SupportService]
    /// Result level id ("notice", "support", "care") to the service id that fits it best.
    let serviceForLevel: [String: String]
    let campusLines: [EmergencyLine]
}

extension SupportData {
    static func institution(id: String?) -> Institution? {
        guard let id else { return nil }
        return institutions.first { $0.id == id }
    }
}
