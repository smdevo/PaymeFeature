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
    @State private var isSuccessFull = false
    @State private var navigateToSuccess = false
    
    @EnvironmentObject var evm: GlobalViewModel
    @EnvironmentObject var fEvm: FamilyViewModel
    @Environment(\.dismiss) private var dismiss
    
    @FocusState var foc: Bool
    
    let id: String
    
    init(id: String) {
        self.id = id
    }
    
    var isAmountValid: Bool {
        if let amount = Double(sum), amount > 0 {
            return true
        }
        return false
    }
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Image("paymeLogo")
                .resizable()
                .scaledToFit()
                .frame(height: 70)
            
            
            
            Text("Send Money")
                .font(.title)
                .bold()
            
            
            Text("To")
                .foregroundStyle(Color.gray)
                .font(.title)
                .bold()
            
            Text("SomeBody")
                .font(.title)
                .bold()
            
            
            Text(evm.currentUser?.role ?? false ?
                 "Do you want to send money to your family card?" :
                    "Do you want to receive money from your family card?")
            .font(.callout)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("How much do you want to transfer?")
                    .font(.subheadline)
                
                NavigationStack {
                    VStack(spacing: 20) {
                        Text(evm.currentUser?.role ?? false ?
                             "Transfer to Family Card" :
                                "Transfer from Family Card")
                        .font(.title2)
                        .bold()
                        
                        
                        Text(evm.currentUser?.role ?? false ?
                             "Do you want to send money to your family card?" :
                                "Do you want to receive money from your family card?")
                        .font(.callout)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("How much do you want to transfer?")
                                .font(.subheadline)
                            
                            TextField("Enter amount", text: $sum)
                                .keyboardType(.decimalPad)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                                .focused($foc)
                        }
                        .padding(.horizontal)
                        
                        Button {
                            isSending = true
                            evm.sendMoney(amount: sum, number: id) { res in
                                DispatchQueue.main.async {
                                    isSending = false
                                    isSuccessFull = res
                                    if res {
                                        sentAmount = sum
                                        navigateToSuccess = true
                                        sum = "" // обнуляем уже после передачи
                                    }
                                }
                            }
                        } label: {
                            Text(isSending ? "Sending..." : "Send")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(isAmountValid ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .disabled(!isAmountValid || isSending)
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        NavigationLink(
                            destination: PaymentSuccessView(amount: "\(sentAmount) сум"),
                            isActive: $navigateToSuccess,
                            label: { EmptyView() }
                        )
                    }
                    .padding()
                }
            }
        }
    }
    
}
//#Preview {
//    TransactionSheet(id: "1")
//        .environmentObject(GlobalViewModel())
//        .environmentObject(FamilyViewModel())
//        
//}
