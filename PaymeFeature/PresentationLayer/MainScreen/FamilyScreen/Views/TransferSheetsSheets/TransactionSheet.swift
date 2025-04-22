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
    
    let completion: () -> Void
    
    @FocusState var foc: Bool
    
    let id: String
    
    init(id: String, completion: @escaping () -> Void) {
        self.id = id
        self.completion = completion
    }
    
    var isAmountValid: Bool {
        if let amount = Int(sum), amount > 0 {
            return true
        }
        return false
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
                .font(.title)
                .bold()
            
            
            Text("To")
                .foregroundStyle(Color.gray)
                .font(.title)
                .bold()
            
            Text(fEvm.allUsers.filter({$0.number == id}).first?.name ?? "Someone")
                .font(.title)
                .bold()
            
            
                VStack(spacing: 20) {
                    
                    
                    TextField("Enter amount", text: $sum)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .focused($foc)
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
                    
                    NavigationLink(
                        destination: PaymentSuccessView(amount: "\(sentAmount) сум", completion: {
                            completion()
                            dismiss()
                        }),
                        isActive: $navigateToSuccess,
                        label: { EmptyView() }
                    )
                }
                .padding()
            }
            
        }
    }//body
    
}

#Preview {
    TransactionSheet(id: "1", completion: {})
        .environmentObject(GlobalViewModel())
        .environmentObject(FamilyViewModel())
    
}
