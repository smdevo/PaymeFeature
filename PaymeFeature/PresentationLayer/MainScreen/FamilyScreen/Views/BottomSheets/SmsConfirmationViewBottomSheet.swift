import SwiftUI

struct SMSConfirmationAlert: View {
    @Binding var isPresented: Bool
    var onCodeConfirmed: (Bool) -> Void

    var body: some View {
        Color.clear
            .alert("Подтверждение SMS", isPresented: $isPresented) {
                Button("OK") {
                    onCodeConfirmed(true)
                }
            } message: {
                Text("На указанный номер отправлено уведомление с кодом")
            }
    }
}


