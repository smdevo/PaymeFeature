//
//  SendMoneySheet.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 07/04/25.
//

import SwiftUI

struct SendMoneySheet: View {
    @Binding var selectedMember: User?
    @Binding var sendAmount: String
    var onSend: () -> Void
    var onCancel: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Отправка денег")
                .font(.headline)
            
            if let member = selectedMember {
                Text("Отправить деньги \(member.name)?")
            }
            
            TextField("Сумма", text: $sendAmount)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            HStack {
                Button("Отмена") {
                    onCancel()
                }
                .padding()
                
                Spacer()
                
                Button("Отправить") {
                    onSend()
                }
                .padding()
            }
            .padding(.horizontal)
        }
        .padding()
    }
}
