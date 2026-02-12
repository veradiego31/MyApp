import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CountdownViewModel()
    @Environment(\.scenePhase) private var scenePhase
    @State private var animateGradient = false

    var body: some View {
        ZStack {
            MeshGradient(
                width: 3, height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], [animateGradient ? 0.6 : 0.4, 0.5], [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: [
                    .indigo, .cyan, .mint,
                    .purple, .indigo, .cyan,
                    .pink, .purple, .indigo
                ]
            )
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                    animateGradient = true
                }
            }

            Group {
                if let event = viewModel.event {
                    CountdownView(
                        event: event,
                        timeComponents: viewModel.timeComponents,
                        onEdit: { viewModel.isShowingEventForm = true },
                        onDelete: { viewModel.deleteEvent() }
                    )
                } else {
                    EmptyStateView {
                        viewModel.isShowingEventForm = true
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.isShowingEventForm) {
            EventFormView(existing: viewModel.event) { event in
                viewModel.saveEvent(event)
            }
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                viewModel.refreshOnForeground()
            }
        }
    }
}

#Preview {
    ContentView()
        .tint(.indigo)
}
