import Foundation

enum Sender {
    case user, assistant
}

struct Message: Identifiable {
    let id = UUID()
    let sender: Sender
    let text: String
}
