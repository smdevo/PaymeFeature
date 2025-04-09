//
//  AddFamilyMember.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 08/04/25.
//
import SwiftUI

struct AddFamilyMember: View {
    @State private var cardNumber: String = ""
    @State private var expiryDate: String = ""
    @State private var phoneNumber: String = ""
    @State private var showSMSAlert: Bool = false
    @State private var isButtonLoading: Bool = false

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 16) {
                    LabeledTextField(
                        label: "Номер телефона",
                        placeholder: "Введите номер телефона",
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
                                showSMSAlert = true
                            }
                        }) {
                            Text("Добавить участника в семью")
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
        .alert("Подтверждение SMS", isPresented: $showSMSAlert) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("На указанный номер отправлено уведомление с кодом")
        }
    }
}

