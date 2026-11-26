import SwiftUI

/// A pointer to support. It never shows a count, a grade or a mark.
struct ResultView: View {
    let summary: WeekSummary
    let openSupport: () -> Void

    @Environment(AppSettings.self) private var settings

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(settings.text(.resultKicker)).font(.subheadline).foregroundStyle(.secondary)
                if summary.skippedEverything {
                    Text(settings.text(.resultAllSkipped))
                } else {
                    LevelPill(level: summary.level)
                    Text(settings.text(summary.level.title)).font(.title.weight(.semibold))
                    Text(settings.text(summary.level.body))

                    Text(settings.text(.resultNoticedHeading)).font(.headline)
                    if summary.yesQuestionIDs.isEmpty {
                        Text(settings.text(.resultNoneNoticed))
                    } else {
                        ForEach(summary.yesQuestionIDs, id: \.self) { id in
                            Label(settings.text(WeeklyQuestions.noticed(id)), systemImage: "circle.fill")
                        }
                    }
                }

                Text(settings.text(.resultNextHeading)).font(.headline)
                if summary.level == .steady {
                    Text(settings.text(.steadyNext))
                }
                Button(settings.text(.seeSupport), action: openSupport)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                Text(settings.text(.saved)).font(.footnote).foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .navigationTitle(settings.text(.resultKicker))
        .navigationBarTitleDisplayMode(.inline)
    }
}
