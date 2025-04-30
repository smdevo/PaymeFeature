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
    @State private var navigateToSuccess = false
    
    @EnvironmentObject var evm: GlobalViewModel
    @EnvironmentObject var fevm: FamilyViewModel
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var foc: Bool
    
    let completion: () -> ()
    let id: String
    
    init(id: String, completion: @escaping () -> ()) {
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
                
                Text("Установить дневной лимит")
                    .font(.title2)
                    .bold()
                
                HStack(alignment: .bottom) {
                    Image("Child")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                        .clipShape(Circle())
                    
                    Text(fevm.allUsers.first(where: { $0.number == id })?.name ?? "Someone")
                        .font(.title)
                        .bold()
                }
                
                TextField("Установить сумму", text: $sum)
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
                    isSetting = true
                    evm.setLimitToFamilyCard(id: id, limit: cleanedSum)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isSetting = false
                        navigateToSuccess = true
                    }
                } label: {
                    Text(isSetting ? "установить..." : "установить")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.paymeC)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .opacity(isAmountValid ? 1 : 0.5)
                }
                .disabled(!isAmountValid || isSetting)
                
                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $navigateToSuccess) {
                CardLimitSetView(limitAmount: sum) {
                    completion()
                }
            }
        }
    }
}
