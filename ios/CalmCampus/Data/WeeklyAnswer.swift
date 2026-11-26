import Foundation
import SwiftData

/// One stored answer: a flat row per question per week. A skipped question is a row too.
/// All rows live on this phone only.
@Model
final class WeeklyAnswer {
    var weekStart: Date
    var answeredAt: Date
    var questionID: String
    var questionVersion: Int
    var responseRaw: String

    init(weekStart: Date, question: WeeklyQuestion, response: WeeklyResponse, answeredAt: Date = .now) {
        self.weekStart = weekStart
        self.answeredAt = answeredAt
        self.questionID = question.id
        self.questionVersion = question.version
        self.responseRaw = response.rawValue
    }

    var response: WeeklyResponse { WeeklyResponse(rawValue: responseRaw) ?? .skipped }
    var stored: StoredAnswer { StoredAnswer(weekStart: weekStart, questionID: questionID, response: response) }
}

extension ModelContext {
    /// Saves a check-in for the week containing `date`. A redo replaces that week, so there is
    /// never more than one entry per week. Missing answers are stored as skipped.
    @discardableResult
    func saveWeeklyCheckin(_ answers: [String: WeeklyResponse], on date: Date = .now,
                           calendar: Calendar = WeeklyScoring.isoCalendar) throws -> Date {
        let week = WeeklyScoring.weekStart(for: date, calendar: calendar)
        for old in try fetch(FetchDescriptor<WeeklyAnswer>(predicate: #Predicate { $0.weekStart == week })) {
            delete(old)
        }
        for question in WeeklyQuestions.all {
            insert(WeeklyAnswer(weekStart: week, question: question,
                                response: answers[question.id] ?? .skipped, answeredAt: date))
        }
        try save()
        return week
    }

    func deleteAllWeeklyData() throws {
        try delete(model: WeeklyAnswer.self)
        try save()
    }
}
