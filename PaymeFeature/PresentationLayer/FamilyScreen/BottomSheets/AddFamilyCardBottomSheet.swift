import SwiftUI

struct FamilyCardAddView: View {
    @State private var cardNumber: String = ""
    @State private var expiryDate: String = ""
    @State private var phoneNumber: String = ""
    @State private var showSMSConfirmationSheet: Bool = false
    @State private var isButtonLoading: Bool = false  // Флаг для отображения загрузки в кнопке

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 16) {
                    LabeledTextField(
                        label: "Номер карты",
                        placeholder: "Введите номер карты",
                        text: $cardNumber,
                        keyboardType: .numberPad
                    )
                    .onChange(of: cardNumber) { newValue, _ in
                        let digits = newValue.filter { $0.isNumber }
                        let limitedDigits = String(digits.prefix(16))
                        var formatted = ""
                        for (index, digit) in limitedDigits.enumerated() {
                            if index > 0 && index % 4 == 0 {
                                formatted.append(" ")
                            }
                            formatted.append(digit)
                        }
                        if formatted != newValue {
                            cardNumber = formatted
                        }
                    }
                    
                    LabeledTextField(
                        label: "Срок действия карты",
                        placeholder: "MM/YY",
                        text: $expiryDate,
                        keyboardType: .numberPad
                    )
                    .onChange(of: expiryDate) { newValue, _ in
                        let digits = newValue.filter { $0.isNumber }
                        let limitedDigits = String(digits.prefix(4))
                        var formatted = ""
                        for (index, digit) in limitedDigits.enumerated() {
                            if index == 2 {
                                formatted.append("/")
                            }
                            formatted.append(digit)
                        }
                        if formatted != newValue {
                            expiryDate = formatted
                        }
                    }
                    
                    LabeledTextField(
                        label: "Номер телефона",
                        placeholder: "Введите номер телефона владельца карты",
                        text: $phoneNumber,
                        keyboardType: .phonePad
                    )
                    .onChange(of: phoneNumber) { newValue, _ in
                        var result = ""
                        if let firstChar = newValue.first, firstChar == "+" {
                            result = "+"
                        }
                        let digits = newValue.filter { $0.isNumber }
                        let limitedDigits = String(digits.prefix(12))
                        let formatted = result + limitedDigits
                        if formatted != newValue {
                            phoneNumber = formatted
                        }
                    }
                    
                    if isButtonLoading {
                        ProgressView()
                            .padding()
                            .frame(maxWidth: .infinity)
                    } else {
                        Button(action: {
                            isButtonLoading = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                isButtonLoading = false
                                showSMSConfirmationSheet = true
                            }
                        }) {
                            Text("Добавить семейную карту")
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
        .sheet(isPresented: $showSMSConfirmationSheet) {
            SMSConfirmationView { success in
                if success {
                    dismiss()
                }
            }
        }
    }
}

struct SMSConfirmationView: View {
    @State private var smsCode: String = ""
    @State private var errorMessage: String = ""
    @State private var isLoading: Bool = false
    
    var onCodeConfirmed: (Bool) -> Void

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("На указанный номер отправлено уведомление с кодом")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                
                TextField("Введите код", text: $smsCode)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                if isLoading {
                    ProgressView()
                        .padding()
                } else {
                    Button("Подтвердить") {
                        if smsCode == "111111" {
                            isLoading = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                onCodeConfirmed(true)
                                dismiss()
                            }
                        } else {
                            errorMessage = "Неверный код. Попробуйте снова."
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                Spacer()
            }
            .navigationBarTitle("Подтверждение SMS", displayMode: .inline)
            .navigationBarItems(trailing: Button("Отмена") {
                dismiss()
            })
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
