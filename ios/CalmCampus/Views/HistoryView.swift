import SwiftData
import SwiftUI

struct HistoryView: View {
    let openSupport: () -> Void

    @Environment(AppSettings.self) private var settings
    @Query(sort: \WeeklyAnswer.weekStart, order: .reverse) private var rows: [WeeklyAnswer]

    var body: some View {
        let weeks = WeeklyScoring.summaries(from: rows.map(\.stored))
        NavigationStack {
            Group {
                if weeks.isEmpty {
                    Text(settings.text(.historyEmpty)).padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                } else {
                    List(weeks) { week in
                        NavigationLink {
                            ResultView(summary: week, openSupport: openSupport)
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(settings.text(.historyWeekOf,
                                                   week.weekStart.formatted(.dateTime.day().month(.abbreviated).locale(settings.language.locale))))
                                    .font(.headline)
                                if week.skippedEverything {
                                    Text(settings.text(.historySkipped)).foregroundStyle(.secondary)
                                } else {
                                    LevelPill(level: week.level)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(settings.text(.historyTitle))
        }
        .disclaimerFooter()
    }
}
