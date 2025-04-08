import SwiftUI

struct AddCardView: View {
    @State private var cardNumber: String = ""
    @State private var cardExpiry: String = ""
    @State private var cardName: String = ""
    @State private var isFamilyCard: Bool = false
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 16) {
                    VStack(spacing: 12) {
                        LabeledTextField(
                            label: "Номер карты",
                            placeholder: "Введите номер карты",
                            text: $cardNumber,
                            keyboardType: .numberPad
                        )
                        LabeledTextField(
                            label: "Срок действия карты",
                            placeholder: "MM/YY",
                            text: $cardExpiry,
                            keyboardType: .numbersAndPunctuation
                        )
                        LabeledTextField(
                            label: "Название карты",
                            placeholder: "Например: Основная",
                            text: $cardName
                        )
                    }
                    .padding(.horizontal)
                    
                        Text("Добавить карту")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
                .padding(.top, 20)
            }
            Spacer(minLength: 0)
        }
   
        .background(Color(UIColor.systemBackground))
    }
}
