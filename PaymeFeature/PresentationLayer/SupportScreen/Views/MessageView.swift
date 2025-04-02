import SwiftUI

struct MessageView: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.sender == .assistant {
                Text(message.text)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                Spacer()
            } else {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 16)
    }
}
