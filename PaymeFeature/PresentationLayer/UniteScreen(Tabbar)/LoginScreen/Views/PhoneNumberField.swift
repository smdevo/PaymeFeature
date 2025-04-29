//
//  PhoneNumberVie.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 15/04/25.
//
import SwiftUI

struct PhoneNumberField: View {
    @Binding var phoneNumber: String

    var body: some View {
        HStack(spacing: .spacing(.x4)) {
            Text("+998")
                .foregroundColor(.primary)
            TextField("Phone number", text: Binding(
                get: {
                    if phoneNumber.hasPrefix("+998 ") {
                        return String(phoneNumber.dropFirst(5))
                    } else if phoneNumber.hasPrefix("+998") {
                        return String(phoneNumber.dropFirst(4))
                    }
                    return phoneNumber
                },
                set: {
                    newValue in
//                    phoneNumber = "+998 " + newValue
                    phoneNumber = newValue
                    
                }
            ))
            .keyboardType(.numberPad)
        }
        .padding(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}
