import SwiftUI

struct SupportView: View {
    @Environment(AppSettings.self) private var settings

    private var institution: Institution? { SupportData.institution(id: settings.institutionID) }

    var body: some View {
        @Bindable var settings = settings
        let language = settings.language
        NavigationStack {
            List {
                Section {
                    Text(settings.text(.supportLead))
                    Text(settings.text(.emergencyIntro)).fontWeight(.semibold)
                }

                Section(settings.text(.institutionHeading)) {
                    Picker(settings.text(.institutionHeading), selection: $settings.institutionID) {
                        Text(settings.text(.institutionNone)).tag(String?.none)
                        ForEach(SupportData.institutions) { item in
                            Text(item.name.resolve(language)).tag(String?.some(item.id))
                        }
                        Text(settings.text(.institutionOther)).tag(String?.some("other"))
                    }
                    Text(settings.text(.institutionHelp)).font(.footnote).foregroundStyle(.secondary)
                }

                if settings.institutionID == "other" {
                    Section { Text(settings.text(.institutionOtherAdvice)) }
                }

                if let institution {
                    Section(settings.text(.institutionServices)) {
                        if let advice = institution.advice { Text(advice.resolve(language)) }
                        ForEach(institution.services) { ServiceRow(service: $0) }
                        ForEach(institution.campusLines) { LineRow(line: $0) }
                    }
                }

                Section(settings.text(.nationalHeading)) {
                    ForEach(SupportData.nationalLines) { LineRow(line: $0) }
                }
            }
            .navigationTitle(settings.text(.supportScreenTitle))
        }
        .disclaimerFooter()
    }
}

private struct ServiceRow: View {
    let service: SupportService
    @Environment(AppSettings.self) private var settings

    var body: some View {
        let language = settings.language
        VStack(alignment: .leading, spacing: 6) {
            Text(service.name.resolve(language)).font(.headline)
            Text(service.purpose.resolve(language)).font(.subheadline)
            if let note = service.note { Text(note.resolve(language)).font(.footnote).foregroundStyle(.secondary) }
            if let hours = service.hours { Text(hours.resolve(language)).font(.footnote).foregroundStyle(.secondary) }
            if let phone = service.phone, let url = URL(string: "tel:" + phone.filter { !$0.isWhitespace }) {
                Link("\(settings.text(.call)) \(phone)", destination: url)
            }
            if let link = service.link, let url = URL(string: link.resolve(language)) {
                Link(settings.text(.website), destination: url)
            }
            if let email = service.email, let url = URL(string: "mailto:" + email) {
                Link("\(settings.text(.email)): \(email)", destination: url)
            }
        }
        .padding(.vertical, 4)
    }
}

private struct LineRow: View {
    let line: EmergencyLine
    @Environment(AppSettings.self) private var settings

    var body: some View {
        let language = settings.language
        VStack(alignment: .leading, spacing: 4) {
            Text(line.label.resolve(language)).font(.headline)
            Text(line.detail.resolve(language)).font(.subheadline).foregroundStyle(.secondary)
            if let url = URL(string: "tel:" + line.tel) {
                Link("\(settings.text(.call)) \(line.number)", destination: url)
            }
        }
        .padding(.vertical, 4)
    }
}
