//
//  TransactionSheet.swift
//  PaymeFeature
//
//  Created by Samandar on 11/04/25.
//

import SwiftUI

struct TransactionSheet: View {
    
    @State private var sum: String = ""
    @State private var isSending = false
    @State private var showConfirmation = false
    @State private var isSuccesFull = false

    @EnvironmentObject var evm: CardsViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    @FocusState var foc: Bool
    
    
    var isAmountValid: Bool {
        if let amount = Double(sum), amount > 0 {
            return true
        }
        return false
    }
    
    var body: some View {
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
                
                evm.sendMoney(amount: sum) { res in
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            isSending = false
                            showConfirmation = true
                            sum = ""
                            isSuccesFull = res
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
        }
        .padding()
        .alert(isSuccesFull ? "Transaction Successful" : "Something went wrong", isPresented: $showConfirmation) {
            Button("OK", role: .cancel) {
                foc = false
                dismiss()
            }
        } message: {
            Text(isSuccesFull ? "Your money has been sent to your family card." : "Something went wrong please try again")
        }
    }
}

//#Preview {
//    TransactionSheet()
//}
