import SwiftUI

struct CountdownView: View {
    let event: CountdownEvent
    let timeComponents: TimeComponents
    let onEdit: () -> Void
    let onDelete: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            Text(event.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .shadow(color: .black.opacity(0.2), radius: 4, y: 2)
                .padding(.horizontal)

            if event.isExpired {
                expiredView
            } else {
                FlipClockView(timeComponents: timeComponents)
                    .padding(.horizontal)
            }

            Spacer()

            HStack(spacing: 16) {
                Button {
                    onEdit()
                } label: {
                    Label("Edit", systemImage: "pencil")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .tint(.white)
                .controlSize(.large)

                Button {
                    onDelete()
                } label: {
                    Label("Delete", systemImage: "trash")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .tint(.white.opacity(0.7))
                .controlSize(.large)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }

    private var expiredView: some View {
        VStack(spacing: 12) {
            Image(systemName: "party.popper.fill")
                .font(.system(size: 48))
                .foregroundStyle(.white)
            Text("Event has arrived!")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.white.opacity(0.8))
        }
    }
}

#Preview {
    ZStack {
        Color.indigo.ignoresSafeArea()
        CountdownView(
            event: CountdownEvent(name: "New Year 2026", targetDate: Date().addingTimeInterval(86400 * 30)),
            timeComponents: TimeComponents(days: 30, hours: 5, minutes: 23, seconds: 10),
            onEdit: {},
            onDelete: {}
        )
    }
}
