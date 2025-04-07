//
//  AddMemberSheet.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 07/04/25.
//

import SwiftUI

struct AddMemberSheet: View {
    @Binding var newCardNumber: String
    var onAdd: () -> Void
    var onCancel: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Добавить члена семьи")
                .font(.headline)
            
            TextField("Введите номер карты", text: $newCardNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding(.horizontal)
            
            HStack {
                Button("Отмена") {
                    onCancel()
                }
                .padding()
                
                Spacer()
                
                Button("Добавить") {
                    onAdd()
                }
                .padding()
            }
            .padding(.horizontal)
        }
        .padding()
    }
}
