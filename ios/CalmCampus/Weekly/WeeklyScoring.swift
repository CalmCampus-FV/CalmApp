import Foundation

/// The four weekly questions. Never change an `id`; bump `version` when the wording changes.
struct WeeklyQuestion: Identifiable, Equatable {
    let id: String
    let version: Int
}

enum WeeklyQuestions {
    static let all: [WeeklyQuestion] = [
        WeeklyQuestion(id: "sleep", version: 1),
        WeeklyQuestion(id: "planning", version: 1),
        WeeklyQuestion(id: "energy", version: 1),
        WeeklyQuestion(id: "connection", version: 2),
    ]
    static var ids: [String] { all.map(\.id) }
}

enum WeeklyResponse: String, Codable, CaseIterable {
    case yes, no, skipped
}

/// How much support to point towards. Not a score and not a diagnosis.
enum ResultLevel: String, CaseIterable {
    case steady, notice, support, care

    /// Same thresholds as the web config: 0 steady, 1 notice, 2 support, 3 or more care.
    static func forYesCount(_ yes: Int) -> ResultLevel {
        switch yes {
        case ..<1: .steady
        case 1: .notice
        case 2: .support
        default: .care
        }
    }
}

/// One stored answer, independent of SwiftData so the rules can be unit-tested.
struct StoredAnswer: Equatable {
    let weekStart: Date
    let questionID: String
    let response: WeeklyResponse
}

struct WeekSummary: Identifiable, Equatable {
    let weekStart: Date
    let answers: [String: WeeklyResponse]
    var id: Date { weekStart }

    /// Only "yes" counts. A skipped question is never a yes.
    var yesCount: Int { answers.values.filter { $0 == .yes }.count }
    var answeredCount: Int { answers.values.filter { $0 != .skipped }.count }
    var level: ResultLevel { .forYesCount(yesCount) }
    var skippedEverything: Bool { answeredCount == 0 }
    var yesQuestionIDs: [String] { WeeklyQuestions.ids.filter { answers[$0] == .yes } }
}

enum WeeklyScoring {
    static func level(for answers: [String: WeeklyResponse]) -> ResultLevel {
        WeekSummary(weekStart: .distantPast, answers: answers).level
    }

    /// Weeks run Monday to Sunday, so there is at most one check-in per week.
    static func weekStart(for date: Date, calendar: Calendar = isoCalendar) -> Date {
        calendar.dateInterval(of: .weekOfYear, for: date)?.start ?? calendar.startOfDay(for: date)
    }

    static var isoCalendar: Calendar { Calendar(identifier: .iso8601) }

    /// Newest week first. Questions with no stored row are treated as skipped.
    static func summaries(from rows: [StoredAnswer]) -> [WeekSummary] {
        let grouped = Dictionary(grouping: rows, by: \.weekStart)
        return grouped.keys.sorted(by: >).map { week in
            var answers: [String: WeeklyResponse] = [:]
            for id in WeeklyQuestions.ids { answers[id] = .skipped }
            for row in grouped[week] ?? [] where WeeklyQuestions.ids.contains(row.questionID) {
                answers[row.questionID] = row.response
            }
            return WeekSummary(weekStart: week, answers: answers)
        }
    }
}
