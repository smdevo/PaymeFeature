//
//  LimitationSheet.swift
//  PaymeFeature
//
//  Created by Samandar on 14/04/25.
//

 
import SwiftUI

struct SettingLimitationSheet: View {
    
    @State private var sum: String = ""
    @State private var isSetting = false
    @State private var showConfirmation = false
    @State private var isSuccesFull = false

    @EnvironmentObject var evm: GlobalViewModel
    
 //   @EnvironmentObject var fEvm: FamilyViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    @FocusState var foc: Bool
    
    let id: String
    
    init(id: String){
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
            
            Text("Setting Spending Limits")
                .font(.title2)
                .bold()
            
            Text("Do you wnat to set daily spending (withdraw) limit for family Card")
                .font(.callout)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("How much do you want to set for?")
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
                isSetting = true
                
               
                
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            isSetting = false
                            showConfirmation = true
                           
                            
//                            evm.limits[id] = Int(sum) ?? 0
                            evm.setLimitToFamilyCard(id: id, limit: sum)
                            
                            isSuccesFull = true
                        }
                
            } label: {
                Text(isSetting ? "Setting..." : "Set")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isAmountValid ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .disabled(!isAmountValid || isSetting)
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .alert("Limit set successfully", isPresented: $showConfirmation) {
            Button("OK", role: .cancel) {
                foc = false
                dismiss()
            }
        } message: {
            Text("Limit has bet Set Successfully")
        }
    }
}
