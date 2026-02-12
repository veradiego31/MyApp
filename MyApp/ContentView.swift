import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CountdownViewModel()
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
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
}
