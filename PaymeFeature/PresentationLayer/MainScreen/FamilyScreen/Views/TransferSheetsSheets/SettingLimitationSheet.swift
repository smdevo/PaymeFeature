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
    @EnvironmentObject var fevm: FamilyViewModel
    
    
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
        VStack(alignment: .leading, spacing: 20) {
            
            ZStack(alignment: .trailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding()
                }
                
                HStack {
                    
                    Spacer()
                    
                    Image("paymeLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 70)
                    
                    Spacer()
                    
                }
            }
            
            
            
            Text("Set Daily Limit")
                .font(.title2)
                .bold()
           
            HStack(alignment: .bottom) {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                    .foregroundStyle(Color.paymeC)
                    
                
                Text(fevm.allUsers.filter({$0.number == id}).first?.name ?? "Someone")
                    .font(.title)
                    .bold()
            }
            
            
                
                TextField("Enter amount", text: $sum)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .focused($foc)
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
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .opacity(isAmountValid ? 1 : 0)
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

#Preview {
    SettingLimitationSheet(id: "")
        .environmentObject(GlobalViewModel())
        .environmentObject(FamilyViewModel())
    
}
