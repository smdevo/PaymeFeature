//
//  TransactionSheet.swift
//  PaymeFeature
//
//  Created by Samandar on 11/04/25.
//

import SwiftUI

struct TransactionSheet: View {
    
    @State private var sum: String = ""
    @State private var sentAmount: String = ""
    @State private var isSending = false
    @State private var navigateToSuccess = false
    
    @EnvironmentObject var evm: GlobalViewModel
    @EnvironmentObject var fEvm: FamilyViewModel
    @Environment(\.dismiss) private var dismiss
    
    let completion: () -> Void
    @FocusState var foc: Bool
    let id: String
    
    init(id: String, completion: @escaping () -> Void) {
        self.id = id
        self.completion = completion
    }
    
    private var cleanedSum: String {
        sum.filter { $0.isNumber }
    }
    
    private var isAmountValid: Bool {
        (Int(cleanedSum) ?? 0) > 0
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                
                Image("paymeLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 70)
                
                Text("Send Money")
                    .font(.title).bold()
                Text("To")
                    .foregroundStyle(Color.gray)
                    .font(.title).bold()
                
                Text(fEvm.allUsers.first(where: { $0.number == id })?.name ?? "Someone")
                    .font(.title).bold()
                
                VStack(spacing: 20) {
                    TextField("Enter amount", text: $sum)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .focused($foc)
                        .padding(.horizontal)
                        .onChange(of: sum) {
                            let digits = sum.filter { $0.isNumber }
                            if let intValue = Int(digits), intValue > 0 {
                                sum = intValue.formattedWithSeparator
                            } else {
                                sum = ""
                            }
                        }
                    
                    Button {
                        isSending = true
                        evm.sendMoney(amount: cleanedSum, number: id) { res in
                            DispatchQueue.main.async {
                                isSending = false
                                if res {
                                    sentAmount = sum   
                                    navigateToSuccess = true
                                    sum = ""
                                }
                            }
                        }
                    } label: {
                        Text(isSending ? "Sending..." : "Send")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.paymeC)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .opacity(isAmountValid ? 1 : 0)
                    
                    Spacer()
                }
                .padding()
            }

            .navigationDestination(isPresented: $navigateToSuccess) {
                PaymentSuccessView(
                    amount: "\(sentAmount) сум",
                    completion: {
                        completion()
                    }
                )
            }
        }
    }
}

#Preview {
    TransactionSheet(id: "1", completion: {})
        .environmentObject(GlobalViewModel())
        .environmentObject(FamilyViewModel())
}
