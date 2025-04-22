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
    @State private var navigateToSuccess = false
    
    
    @EnvironmentObject var evm: GlobalViewModel
    @EnvironmentObject var fevm: FamilyViewModel
    
    
    @Environment(\.dismiss) private var dismiss
    
    @FocusState var foc: Bool
    
    let completion: () -> ()
    
    let id: String
    
    init(id: String, completion: @escaping () -> ()){
        self.id = id
        self.completion = completion
    }
    
    var isAmountValid: Bool {
        if let amount = Double(sum), amount > 0 {
            return true
        }
        return false
    }
    
    var body: some View {
        
        NavigationStack {
            
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
                    Image("Child")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                        .clipShape(Circle())
                    
                    
                    Text(fevm.allUsers.filter({$0.number == id}).first?.name ?? "Someone")
                        .font(.title)
                        .bold()
                }
                
                
                
                TextField("Set amount", text: $sum)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .focused($foc)
                
                
                Button {
                    isSetting = true
                    
                    DispatchQueue.main.async {
                        isSetting = false
                        navigateToSuccess = true
                        
                        
                        evm.setLimitToFamilyCard(id: id, limit: sum)
                        
                        isSuccesFull = true
                    }
                    
                } label: {
                    Text(isSetting ? "Setting..." : "Set")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.theme.paymeC)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .opacity(isAmountValid ? 1 : 0)
                }
                .disabled(!isAmountValid || isSetting)
                
                Spacer()
                
                NavigationLink(
                    destination: CardLimitSetView(limitAmount: sum, completion: {
                        completion()
                    }),
                    isActive: $navigateToSuccess,
                    label: { EmptyView() }
                )
            }
            .padding()
            
        }//NAStack
    }//body
}


#Preview {
    SettingLimitationSheet(id: "", completion: {})
        .environmentObject(GlobalViewModel())
        .environmentObject(FamilyViewModel())
}
