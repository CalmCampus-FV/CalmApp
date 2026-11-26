import SwiftUI

/// One question at a time. Yes, No or skip; every question can be skipped.
struct CheckinFlowView: View {
    let onFinish: ([String: WeeklyResponse]) -> Void
    let onCancel: () -> Void

    @Environment(AppSettings.self) private var settings
    @State private var index = 0
    @State private var answers: [String: WeeklyResponse] = [:]

    private let questions = WeeklyQuestions.all

    var body: some View {
        let question = questions[index]
        VStack(alignment: .leading, spacing: 20) {
            Text(settings.text(.progress, index + 1, questions.count))
                .font(.subheadline).foregroundStyle(.secondary)
            ProgressView(value: Double(index), total: Double(questions.count))
            Text(settings.text(.checkinHeading)).font(.headline)
            Text(settings.text(WeeklyQuestions.prompt(question.id)))
                .font(.title2.weight(.semibold))
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
            HStack(spacing: 12) {
                answerButton(.yes, question)
                answerButton(.no, question)
            }
            Button(settings.text(.skip)) { record(.skipped, for: question) }
                .frame(maxWidth: .infinity)
            Button(settings.text(.back)) { goBack() }
                .frame(maxWidth: .infinity)
        }
        .padding()
        .id(question.id)
        .disclaimerFooter()
    }

    private func answerButton(_ response: WeeklyResponse, _ question: WeeklyQuestion) -> some View {
        Button { record(response, for: question) } label: {
            Text(settings.text(response == .yes ? .yes : .no)).frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }

    private func record(_ response: WeeklyResponse, for question: WeeklyQuestion) {
        answers[question.id] = response
        if index + 1 < questions.count {
            index += 1
        } else {
            onFinish(answers)
        }
    }

    private func goBack() {
        if index > 0 { index -= 1 } else { onCancel() }
    }
}
