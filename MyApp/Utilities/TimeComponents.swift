import Foundation

struct TimeComponents: Equatable {
    let days: Int
    let hours: Int
    let minutes: Int
    let seconds: Int

    var dayDigits: [Int] {
        digits(from: days, minCount: 2)
    }

    var hourDigits: [Int] {
        digits(from: hours, minCount: 2)
    }

    var minuteDigits: [Int] {
        digits(from: minutes, minCount: 2)
    }

    var secondDigits: [Int] {
        digits(from: seconds, minCount: 2)
    }

    static let zero = TimeComponents(days: 0, hours: 0, minutes: 0, seconds: 0)

    static func from(now: Date, to target: Date) -> TimeComponents {
        guard target > now else { return .zero }
        let interval = Int(target.timeIntervalSince(now))
        let d = interval / 86400
        let h = (interval % 86400) / 3600
        let m = (interval % 3600) / 60
        let s = interval % 60
        return TimeComponents(days: d, hours: h, minutes: m, seconds: s)
    }

    private func digits(from value: Int, minCount: Int) -> [Int] {
        guard value > 0 else {
            return Array(repeating: 0, count: minCount)
        }
        var result: [Int] = []
        var remaining = value
        while remaining > 0 {
            result.insert(remaining % 10, at: 0)
            remaining /= 10
        }
        while result.count < minCount {
            result.insert(0, at: 0)
        }
        return result
    }
}
