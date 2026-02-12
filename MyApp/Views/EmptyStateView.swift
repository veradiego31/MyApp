import SwiftUI

struct EmptyStateView: View {
    let onSetEvent: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "clock.badge.questionmark")
                .font(.system(size: 64))
                .foregroundStyle(.secondary)

            VStack(spacing: 8) {
                Text("No Event Set")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Create a countdown to something exciting!")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            Button {
                onSetEvent()
            } label: {
                Label("Set Event", systemImage: "plus.circle.fill")
                    .font(.headline)
                    .frame(maxWidth: 220)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    EmptyStateView(onSetEvent: {})
}
