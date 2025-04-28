import SwiftUI

struct FamilyCardAddView: View {
    @ObservedObject var viewModel: FamilyViewModel
    
    @State private var passport: String = "518281726700021"
    @State private var phoneNumber: String = ""
    @State private var pin: String = ""
    @State private var isButtonLoading: Bool = false
    
    let onSuccess: () -> Void

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Добавить детский счёт")
                .font(.title)
                .padding()
            
            
            LabeledTextField(
                label: "Номер и серия ПИНФЛа ребёнка",
                placeholder: "Введите номер и серию паспорта",
                text: $passport,
                keyboardType: .default
            )
            .disabled(true)
            .opacity(0.6) 
            
//            LabeledTextField(
//                label: "Номер телефона",
//                placeholder: "Введите номер телефона владельца карты",
//                text: $phoneNumber,
//                keyboardType: .phonePad
//            )
            
            
            LabeledTextField(
                label: "ПИН-код",
                placeholder: "Введите ПИН-код для ребёнка",
                text: $pin,
                keyboardType: .phonePad
            )
            
            if isButtonLoading {
                ProgressView()
                    .padding()
                    .frame(maxWidth: .infinity)
            } else {
                Button(action: {
                    guard !phoneNumber.isEmpty else { return }
                    
                    let userAddCardName = viewModel.allUsers.first { user in
                        user.number == phoneNumber
                    }
                    guard let firstUser = userAddCardName else { return }
                    
                    isButtonLoading = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        viewModel.addFamilyCard(
                            cardName: firstUser.name,
                            ownerPhoneNumber: phoneNumber
                        ) { success in
                            
                            isButtonLoading = false
                            
                            if success {
                                onSuccess()
                                dismiss()
                            }
                            
                        }
                    }
                }) {
                    Text("Открыть детский счёт")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.paymeC)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
    }
}
