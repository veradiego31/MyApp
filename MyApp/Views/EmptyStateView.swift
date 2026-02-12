import SwiftUI

struct EmptyStateView: View {
    let onSetEvent: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "clock.badge.questionmark")
                .font(.system(size: 64))
                .foregroundStyle(.white.opacity(0.7))

            VStack(spacing: 8) {
                Text("No Event Set")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Text("Create a countdown to something exciting!")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
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
            .tint(.white.opacity(0.25))
            .foregroundStyle(.white)
            .controlSize(.large)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ZStack {
        Color.indigo.ignoresSafeArea()
        EmptyStateView(onSetEvent: {})
    }
}
