import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CountdownViewModel()
    @Environment(\.scenePhase) private var scenePhase
    @State private var animateGradient = false
    private let colorsA: [Color] = [
        .indigo, .cyan, .mint,
        .purple, .indigo, .cyan,
        .pink, .purple, .indigo
    ]
    private let colorsB: [Color] = [
        .pink, .purple, .indigo,
        .cyan, .mint, .purple,
        .indigo, .cyan, .mint
    ]

    var body: some View {
        ZStack {
            MeshGradient(
                width: 3, height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: animateGradient ? colorsB : colorsA
            )
            .ignoresSafeArea()
            .onAppear {
                startGradientAnimationIfNeeded()
            }

            Group {
                if let event = viewModel.event {
                    CountdownView(
                        event: event,
                        timeComponents: viewModel.timeComponents,
                        onEdit: showEventForm,
                        onDelete: { viewModel.deleteEvent() }
                    )
                } else {
                    EmptyStateView(onSetEvent: showEventForm)
                }
            }
        }
        .sheet(isPresented: $viewModel.isShowingEventForm) {
            EventFormView(existing: viewModel.event) { event in
                viewModel.saveEvent(event)
            }
        }
        .onChange(of: scenePhase) { _, newPhase in
            switch newPhase {
            case .active:
                viewModel.refreshOnForeground()
                startGradientAnimationIfNeeded()
            case .inactive, .background:
                viewModel.pauseTimer()
                animateGradient = false
            @unknown default:
                break
            }
        }
    }

    private func showEventForm() {
        viewModel.isShowingEventForm = true
    }

    private func startGradientAnimationIfNeeded() {
        guard !animateGradient else { return }
        withAnimation(.easeInOut(duration: 6).repeatForever(autoreverses: true)) {
            animateGradient = true
        }
    }
}

#Preview {
    ContentView()
        .tint(.indigo)
}
