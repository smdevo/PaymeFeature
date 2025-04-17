//
//  LabeledTextField.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 16/04/25.
//
import SwiftUI

struct LabeledTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .padding(10)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
        }
        .padding(.horizontal)
    }
}
