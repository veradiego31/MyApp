import Foundation

struct CountdownEvent: Codable, Equatable {
    let id: UUID
    var name: String
    var targetDate: Date

    var isExpired: Bool {
        targetDate <= Date()
    }

    init(id: UUID = UUID(), name: String, targetDate: Date) {
        self.id = id
        self.name = name
        self.targetDate = targetDate
    }
}
