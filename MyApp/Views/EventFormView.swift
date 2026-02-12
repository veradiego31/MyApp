import SwiftUI

struct EventFormView: View {
    let existing: CountdownEvent?
    let onSave: (CountdownEvent) -> Void
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var targetDate: Date = Calendar.current.date(
        byAdding: .day, value: 1, to: Date()
    ) ?? Date()

    var body: some View {
        NavigationStack {
            Form {
                Section("Event Name") {
                    TextField("e.g. New Year, Birthday...", text: $name)
                }

                Section("Date & Time") {
                    DatePicker(
                        "Target",
                        selection: $targetDate,
                        in: Date()...,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.graphical)
                }
            }
            .navigationTitle(existing == nil ? "New Event" : "Edit Event")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let event = CountdownEvent(
                            id: existing?.id ?? UUID(),
                            name: name.trimmingCharacters(in: .whitespaces),
                            targetDate: targetDate
                        )
                        onSave(event)
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .onAppear {
                if let existing {
                    name = existing.name
                    targetDate = existing.targetDate
                }
            }
        }
    }
}

#Preview {
    EventFormView(existing: nil) { event in
        print(event.name)
    }
}
