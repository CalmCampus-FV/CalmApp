import XCTest
@testable import CalmCampus

/// Wording rules for user-facing v1 copy (see CLAUDE.md).
final class WordingTests: XCTestCase {
    /// Every user-facing string in every language, except the disclaimer, which must say it does not diagnose.
    private var strings: [(label: String, text: String)] {
        var result: [(String, String)] = []
        for key in S.allCases where key != .disclaimer {
            for language in AppLanguage.allCases { result.append(("\(key).\(language)", key.text(language))) }
        }
        result += supportTexts
        return result
    }

    private var supportTexts: [(String, String)] {
        var result: [(String, String)] = []
        func add(_ label: String, _ t: LocalizedText?) {
            guard let t else { return }
            for (i, value) in t.allValues.enumerated() { result.append(("\(label)#\(i)", value)) }
        }
        for institution in SupportData.institutions {
            add(institution.id + ".name", institution.name)
            add(institution.id + ".hint", institution.hint)
            add(institution.id + ".advice", institution.advice)
            for service in institution.services {
                add(service.id + ".name", service.name); add(service.id + ".purpose", service.purpose)
                add(service.id + ".note", service.note); add(service.id + ".hours", service.hours)
            }
            for line in institution.campusLines { add(line.id + ".label", line.label); add(line.id + ".detail", line.detail) }
        }
        for line in SupportData.nationalLines { add(line.id + ".label", line.label); add(line.id + ".detail", line.detail) }
        return result
    }

    private let banned = [
        "detect", "détect", "diagnosis", "early sign", "early warning", "burnout", "burn-out",
        "premiers signes", "vroege signalen", "opspor", "repérer", "stop burnout", "reach the right support",
        "seconds", "secondes", "seconden", "\u{2014}",
    ]

    func testNoBannedWordsInAnyLanguage() {
        for (label, text) in strings {
            for word in banned {
                XCTAssertFalse(text.lowercased().contains(word), "\(label) contains \"\(word)\": \(text)")
            }
        }
    }

    func testNoEmDashAnywhereIncludingDisclaimer() {
        for language in AppLanguage.allCases {
            XCTAssertFalse(S.disclaimer.text(language).contains("\u{2014}"))
        }
    }

    func testNoTimeInSeconds() {
        let pattern = try! NSRegularExpression(pattern: "\\b\\d+\\s*(s|sec|secs|seconds?|secondes?|seconden)\\b", options: .caseInsensitive)
        for (label, text) in strings {
            XCTAssertNil(pattern.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)), "\(label): \(text)")
        }
    }

    func testEveryStringExistsInAllThreeLanguages() {
        for key in S.allCases {
            let entry = S.table[key]
            XCTAssertNotNil(entry, "missing \(key)")
            XCTAssertFalse(entry?.en.isEmpty ?? true); XCTAssertFalse(entry?.nl.isEmpty ?? true)
            XCTAssertFalse(entry?.fr?.isEmpty ?? true, "\(key) has no French")
        }
    }

    func testDisclaimerSaysEverythingRequired() {
        let en = S.disclaimer.text(.en).lowercased()
        XCTAssertTrue(en.contains("students, not medical professionals"))
        XCTAssertTrue(en.contains("does not diagnose or treat"))
        XCTAssertTrue(en.contains("strongly suggest"))
        XCTAssertTrue(en.contains("doctor"))
        XCTAssertTrue(en.contains("student support"))
        for language in AppLanguage.allCases {
            XCTAssertFalse(S.staysOnPhone.text(language).isEmpty)
        }
        XCTAssertTrue(S.staysOnPhone.text(.en).lowercased().contains("stay on this phone"))
    }

    func testCreditKeepsTheUGrave() {
        for language in AppLanguage.allCases {
            let credit = S.aboutCredit.text(language)
            XCTAssertTrue(credit.contains("Braùn"))
            XCTAssertTrue(credit.contains("Hélène David"))
        }
        XCTAssertEqual(S.aboutCredit.text(.en), "Made by Florian Braùn and Hélène David.")
    }

    func testQuestionWordingMatchesTheWebPreview() {
        XCTAssertEqual(S.qSleep.text(.en), "This week, has your sleep been worse than usual?")
        XCTAssertEqual(S.qConnection.text(.nl), "Ging je vrienden, lessen of plannen meer uit de weg dan gewoonlijk?")
        XCTAssertEqual(S.qPlanning.text(.fr), "As-tu eu du mal à organiser ou à planifier tes études ?")
    }

    func testResultNeverShowsAScoreLikeXOfFour() {
        let pattern = try! NSRegularExpression(pattern: "\\b\\d\\s*(of|van|sur|/)\\s*4\\b", options: .caseInsensitive)
        for (label, text) in strings {
            XCTAssertNil(pattern.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)), "\(label): \(text)")
        }
    }

    func testCheckinIsDescribedAsLessThanAMinute() {
        XCTAssertTrue(S.homeLead.text(.en).contains("less than a minute"))
        XCTAssertTrue(S.welcomePoint1.text(.nl).contains("minder dan een minuut"))
        XCTAssertTrue(S.welcomePoint1.text(.fr).contains("moins d'une minute"))
    }
}
