import SwiftUI

/// The disclaimer shown at the bottom of every screen.
struct DisclaimerFooter: View {
    @Environment(AppSettings.self) private var settings

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(settings.text(.disclaimer))
            Text(settings.text(.staysOnPhone)).fontWeight(.semibold)
        }
        .font(.caption)
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(.bar)
        .accessibilityElement(children: .combine)
    }
}

extension View {
    func disclaimerFooter() -> some View {
        safeAreaInset(edge: .bottom, spacing: 0) { DisclaimerFooter() }
    }
}

struct LevelPill: View {
    let level: ResultLevel
    @Environment(AppSettings.self) private var settings

    var body: some View {
        Text(settings.text(level.pill))
            .font(.subheadline.weight(.semibold))
            .padding(.horizontal, 12).padding(.vertical, 4)
            .background(Capsule().fill(Color.accentColor.opacity(0.15)))
    }
}

struct LanguagePicker: View {
    @Environment(AppSettings.self) private var settings

    var body: some View {
        @Bindable var settings = settings
        Picker(settings.text(.languageHeading), selection: $settings.languageOverride) {
            Text(settings.text(.languageDevice)).tag(AppLanguage?.none)
            ForEach(AppLanguage.allCases) { language in
                Text(language.nativeName).tag(AppLanguage?.some(language))
            }
        }
    }
}
