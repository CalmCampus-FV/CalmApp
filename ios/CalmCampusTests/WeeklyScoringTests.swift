import XCTest
@testable import CalmCampus

final class WeeklyScoringTests: XCTestCase {
    private func answers(_ yes: Int, skipped: Int = 0) -> [String: WeeklyResponse] {
        var result: [String: WeeklyResponse] = [:]
        for (i, id) in WeeklyQuestions.ids.enumerated() {
            if i < yes { result[id] = .yes } else if i >= WeeklyQuestions.ids.count - skipped { result[id] = .skipped } else { result[id] = .no }
        }
        return result
    }

    func testQuestionIDsMatchTheWebPreview() {
        XCTAssertEqual(WeeklyQuestions.ids, ["sleep", "planning", "energy", "connection"])
    }

    func testThresholdsMatchTheWebConfig() {
        XCTAssertEqual(ResultLevel.forYesCount(0), .steady)
        XCTAssertEqual(ResultLevel.forYesCount(1), .notice)
        XCTAssertEqual(ResultLevel.forYesCount(2), .support)
        XCTAssertEqual(ResultLevel.forYesCount(3), .care)
        XCTAssertEqual(ResultLevel.forYesCount(4), .care)
    }

    func testOnlyYesAnswersCount() {
        XCTAssertEqual(WeeklyScoring.level(for: answers(0)), .steady)
        XCTAssertEqual(WeeklyScoring.level(for: answers(2)), .support)
        XCTAssertEqual(WeeklyScoring.level(for: answers(4)), .care)
    }

    func testSkipsAreNotYes() {
        let summary = WeekSummary(weekStart: .now, answers: answers(1, skipped: 3))
        XCTAssertEqual(summary.yesCount, 1)
        XCTAssertEqual(summary.answeredCount, 1)
        XCTAssertEqual(summary.level, .notice)
    }

    func testSkippingEverythingIsSteadyButFlagged() {
        let summary = WeekSummary(weekStart: .now, answers: Dictionary(uniqueKeysWithValues: WeeklyQuestions.ids.map { ($0, WeeklyResponse.skipped) }))
        XCTAssertEqual(summary.yesCount, 0)
        XCTAssertTrue(summary.skippedEverything)
    }

    func testMissingRowsCountAsSkipped() {
        let week = Date(timeIntervalSince1970: 0)
        let rows = [StoredAnswer(weekStart: week, questionID: "sleep", response: .yes)]
        let summary = WeeklyScoring.summaries(from: rows)[0]
        XCTAssertEqual(summary.answers["planning"], .skipped)
        XCTAssertEqual(summary.yesQuestionIDs, ["sleep"])
    }

    func testSummariesAreNewestFirst() {
        let old = Date(timeIntervalSince1970: 0), new = Date(timeIntervalSince1970: 700_000)
        let rows = [StoredAnswer(weekStart: old, questionID: "sleep", response: .no),
                    StoredAnswer(weekStart: new, questionID: "sleep", response: .no)]
        XCTAssertEqual(WeeklyScoring.summaries(from: rows).map(\.weekStart), [new, old])
    }

    func testWeekStartIsMondayAndStableWithinAWeek() {
        var calendar = WeeklyScoring.isoCalendar
        calendar.timeZone = TimeZone(identifier: "Europe/Brussels")!
        let wednesday = calendar.date(from: DateComponents(year: 2026, month: 11, day: 25, hour: 15))!
        let sunday = calendar.date(from: DateComponents(year: 2026, month: 11, day: 29, hour: 23))!
        let nextMonday = calendar.date(from: DateComponents(year: 2026, month: 11, day: 30, hour: 1))!
        let start = WeeklyScoring.weekStart(for: wednesday, calendar: calendar)
        XCTAssertEqual(calendar.component(.weekday, from: start), 2)
        XCTAssertEqual(start, WeeklyScoring.weekStart(for: sunday, calendar: calendar))
        XCTAssertNotEqual(start, WeeklyScoring.weekStart(for: nextMonday, calendar: calendar))
    }
}
