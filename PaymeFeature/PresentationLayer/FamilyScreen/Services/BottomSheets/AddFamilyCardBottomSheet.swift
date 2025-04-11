import SwiftUI

struct FamilyCardAddView: View {
    
    @ObservedObject var viewModel: FamilyViewModel
    
    @State private var passport: String = ""
    @State private var address: String = ""
    @State private var phoneNumber: String = ""
    @State private var isButtonLoading: Bool = false
    @State private var showOrderAlert: Bool = false

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 16) {
           
                    LabeledTextField(
                        label: "Номер и серия паспорта",
                        placeholder: "Введите номер и серию паспорта",
                        text: $passport,
                        keyboardType: .default
                    )
           
                    LabeledTextField(
                        label: "Адрес",
                        placeholder: "Введите адрес",
                        text: $address,
                        keyboardType: .default
                    )
                    
                    LabeledTextField(
                        label: "Номер телефона",
                        placeholder: "Введите номер телефона владельца карты",
                        text: $phoneNumber,
                        keyboardType: .phonePad
                    )
             
                    if isButtonLoading {
                        ProgressView()
                            .padding()
                            .frame(maxWidth: .infinity)
                    } else {
                        Button(action: {
                            guard !phoneNumber.isEmpty else { return }
                            
                            isButtonLoading = true
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                viewModel.addFamilyCard(cardName: "Семейная карта", ownerPhoneNumber: phoneNumber) { success in
                                    isButtonLoading = false
                                    
                                    if success {
                                        viewModel.refreshData()
                                        showOrderAlert = true
                                    }
                                }
                            }
                        }) {
                            Text("Заказать семейную карту")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)

                    }
                }
                .padding()
            }
            Spacer(minLength: 0)
        }
        .background(Color(UIColor.systemBackground))
        .alert("Заказ карты", isPresented: $showOrderAlert) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("Ваша карта будет готова в ближайшие дни")
        }
    }
}

struct LabeledTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .padding(10)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
        }
        .padding(.horizontal)
    }
}
