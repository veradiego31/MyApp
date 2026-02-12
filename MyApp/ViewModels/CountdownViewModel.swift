import SwiftUI
import Combine

@MainActor
final class CountdownViewModel: ObservableObject {
    @Published var event: CountdownEvent?
    @Published var timeComponents: TimeComponents = .zero
    @Published var isShowingEventForm = false

    private var timerCancellable: AnyCancellable?
    private let userDefaultsKey = "countdown_event"

    init() {
        loadEvent()
        startTimerIfNeeded()
    }

    // MARK: - Persistence

    func saveEvent(_ event: CountdownEvent) {
        self.event = event
        if let data = try? JSONEncoder().encode(event) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
        refreshTimeComponents()
        startTimerIfNeeded()
    }

    func deleteEvent() {
        event = nil
        timeComponents = .zero
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
        stopTimer()
    }

    func refreshOnForeground() {
        refreshTimeComponents()
        startTimerIfNeeded()
    }

    func pauseTimer() {
        stopTimer()
    }

    // MARK: - Private

    private func loadEvent() {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let saved = try? JSONDecoder().decode(CountdownEvent.self, from: data) else {
            return
        }
        event = saved
        refreshTimeComponents()
    }

    private func refreshTimeComponents() {
        guard let event else {
            timeComponents = .zero
            return
        }
        timeComponents = TimeComponents.from(now: Date(), to: event.targetDate)
    }

    private func startTimerIfNeeded() {
        stopTimer()
        guard let event, !event.isExpired else { return }

        timerCancellable = Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }

    private func tick() {
        refreshTimeComponents()
        if event?.isExpired == true {
            stopTimer()
        }
    }

    private func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }
}
