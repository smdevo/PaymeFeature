import Foundation

struct User: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let age: Int
    var balance: Double
    let userName: String
    let password: String
    let date: TimeInterval
    var friends: [User]? = []
    let cardNumber: String? 
    let avatar: String?
    let role: String
    var cards: [Card] = []
    var transactions: [Transaction]? = []
    var subscriptions: [Subscription]? = []
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}

