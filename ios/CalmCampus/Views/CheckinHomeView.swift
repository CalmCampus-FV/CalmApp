import SwiftData
import SwiftUI

struct CheckinHomeView: View {
    let openSupport: () -> Void

    @Environment(AppSettings.self) private var settings
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \WeeklyAnswer.weekStart, order: .reverse) private var rows: [WeeklyAnswer]
    @State private var asking = false
    @State private var showResult = false

    private var thisWeek: WeekSummary? {
        let week = WeeklyScoring.weekStart(for: .now)
        return WeeklyScoring.summaries(from: rows.map(\.stored)).first { $0.weekStart == week }
    }

    var body: some View {
        NavigationStack {
            Group {
                if asking {
                    CheckinFlowView { answers in
                        _ = try? modelContext.saveWeeklyCheckin(answers)
                        asking = false
                        showResult = true
                    } onCancel: { asking = false }
                } else {
                    home
                }
            }
            .navigationTitle(settings.text(.tabCheckin))
            .navigationDestination(isPresented: $showResult) {
                if let summary = thisWeek {
                    ResultView(summary: summary, openSupport: openSupport)
                }
            }
        }
        .disclaimerFooter()
    }

    private var home: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if thisWeek != nil {
                    Label(settings.text(.homeDoneTitle), systemImage: "checkmark.circle.fill")
                        .font(.title2.weight(.semibold))
                    Text(settings.text(.homeDoneBody))
                    Button(settings.text(.homeViewResult)) { showResult = true }
                        .buttonStyle(.borderedProminent)
                    Button(settings.text(.homeRedo)) { asking = true }
                } else {
                    Text(settings.text(.homeTitle)).font(.title.weight(.semibold))
                    Text(settings.text(.homeLead))
                    Button(settings.text(.homeStart)) { asking = true }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
}
