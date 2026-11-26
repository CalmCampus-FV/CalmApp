import SwiftData
import XCTest
@testable import CalmCampus

final class WeeklyStorageTests: XCTestCase {
    private var calendar: Calendar {
        var c = WeeklyScoring.isoCalendar
        c.timeZone = TimeZone(identifier: "Europe/Brussels")!
        return c
    }

    private func makeContext() throws -> ModelContext {
        let container = try ModelContainer(for: WeeklyAnswer.self,
                                           configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        return ModelContext(container)
    }

    private func all(_ context: ModelContext) throws -> [WeeklyAnswer] {
        try context.fetch(FetchDescriptor<WeeklyAnswer>())
    }

    func testOneEntryPerWeekEvenWhenRedone() throws {
        let context = try makeContext()
        let monday = calendar.date(from: DateComponents(year: 2026, month: 11, day: 23, hour: 9))!
        let friday = calendar.date(from: DateComponents(year: 2026, month: 11, day: 27, hour: 9))!
        try context.saveWeeklyCheckin(["sleep": .yes, "planning": .yes], on: monday, calendar: calendar)
        try context.saveWeeklyCheckin(["sleep": .no, "planning": .no, "energy": .no, "connection": .no], on: friday, calendar: calendar)

        let rows = try all(context)
        XCTAssertEqual(rows.count, WeeklyQuestions.all.count)
        XCTAssertEqual(Set(rows.map(\.weekStart)).count, 1)
        XCTAssertEqual(WeeklyScoring.summaries(from: rows.map(\.stored))[0].level, .steady)
    }

    func testDifferentWeeksAreKeptSeparately() throws {
        let context = try makeContext()
        let week1 = calendar.date(from: DateComponents(year: 2026, month: 11, day: 17))!
        let week2 = calendar.date(from: DateComponents(year: 2026, month: 11, day: 24))!
        try context.saveWeeklyCheckin(["sleep": .yes], on: week1, calendar: calendar)
        try context.saveWeeklyCheckin(["sleep": .no], on: week2, calendar: calendar)
        XCTAssertEqual(try all(context).count, WeeklyQuestions.all.count * 2)
        XCTAssertEqual(WeeklyScoring.summaries(from: try all(context).map(\.stored)).count, 2)
    }

    func testUnansweredQuestionsAreStoredAsSkipped() throws {
        let context = try makeContext()
        try context.saveWeeklyCheckin(["sleep": .yes], calendar: calendar)
        let rows = try all(context)
        XCTAssertEqual(rows.count, 4)
        XCTAssertEqual(rows.filter { $0.response == .skipped }.count, 3)
        XCTAssertEqual(rows.first { $0.questionID == "connection" }?.questionVersion, 2)
    }

    func testDeleteAllRemovesEverything() throws {
        let context = try makeContext()
        try context.saveWeeklyCheckin(["sleep": .yes], calendar: calendar)
        try context.deleteAllWeeklyData()
        XCTAssertTrue(try all(context).isEmpty)
    }
}
