//
//  HeadLineView.swift
//  PaymeFeature
//
//  Created by Samandar on 08/04/25.
//

import SwiftUI

struct HeadLineView: View {
    let title: String
    let isOn: Bool
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(isOn ? .blue : .gray)
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isOn ? Color.blue.opacity(0.1) : Color.clear)
            )
            .animation(.easeInOut, value: isOn)
    }
}
