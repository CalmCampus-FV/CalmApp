import XCTest
@testable import CalmCampus

final class SettingsAndLanguageTests: XCTestCase {
    private func makeDefaults() -> UserDefaults {
        let name = "calmcampus.tests.\(UUID().uuidString)"
        let defaults = UserDefaults(suiteName: name)!
        defaults.removePersistentDomain(forName: name)
        return defaults
    }

    func testDeviceLanguageIsUsedWhenSupported() {
        XCTAssertEqual(AppLanguage.fromDevice(preferred: ["fr-BE"]), .fr)
        XCTAssertEqual(AppLanguage.fromDevice(preferred: ["nl-BE", "en"]), .nl)
        XCTAssertEqual(AppLanguage.fromDevice(preferred: ["de-DE", "nl"]), .nl)
        XCTAssertEqual(AppLanguage.fromDevice(preferred: ["en-GB"]), .en)
    }

    func testUnsupportedDeviceLanguageFallsBackToEnglish() {
        XCTAssertEqual(AppLanguage.fromDevice(preferred: ["de-DE", "ja"]), .en)
        XCTAssertEqual(AppLanguage.fromDevice(preferred: []), .en)
    }

    func testOverrideBeatsDeviceAndPersists() {
        let defaults = makeDefaults()
        let settings = AppSettings(defaults: defaults, deviceLanguage: { .fr })
        XCTAssertEqual(settings.language, .fr)
        settings.languageOverride = .nl
        XCTAssertEqual(AppSettings(defaults: defaults, deviceLanguage: { .fr }).language, .nl)
    }

    func testRemindersAreOffByDefault() {
        XCTAssertFalse(AppSettings(defaults: makeDefaults()).reminderEnabled)
    }

    func testResetClearsChoicesButNotWelcome() {
        let settings = AppSettings(defaults: makeDefaults(), deviceLanguage: { .en })
        settings.welcomeSeen = true
        settings.institutionID = "ugent"
        settings.languageOverride = .nl
        settings.reminderEnabled = true
        settings.reset()
        XCTAssertNil(settings.institutionID)
        XCTAssertNil(settings.languageOverride)
        XCTAssertFalse(settings.reminderEnabled)
        XCTAssertTrue(settings.welcomeSeen)
    }

    func testReminderIsWeeklyAndLocal() {
        let trigger = ReminderScheduler.trigger()
        XCTAssertTrue(trigger.repeats)
        XCTAssertEqual(trigger.dateComponents.weekday, 1)
    }

    func testCheckinWorksWithoutInstitution() {
        XCTAssertNil(SupportData.institution(id: nil))
        let other = SupportData.institution(id: "other")
        XCTAssertNotNil(other)
        XCTAssertNotNil(other?.advice)
        XCTAssertTrue(other?.services.isEmpty ?? false)
    }

    func testInstitutionsAndNationalLines() {
        XCTAssertEqual(SupportData.institutions.map(\.id), ["kuleuven", "kulak", "ugent", "uantwerpen", "vub", "uhasselt", "other"])
        XCTAssertEqual(SupportData.nationalLines.map(\.number), ["112", "1813", "106", "107", "0800 32 123"])
        for institution in SupportData.institutions {
            for service in institution.serviceForLevel.values {
                XCTAssertTrue(institution.services.contains { $0.id == service }, "\(institution.id) maps to missing service \(service)")
            }
        }
    }
}
