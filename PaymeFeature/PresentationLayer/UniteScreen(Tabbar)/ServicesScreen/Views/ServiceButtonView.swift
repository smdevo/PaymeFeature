//
//  AuthScreen.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

struct ServiceButton: View {
    let service: Service

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: service.iconName)
                .font(.title2)
                .foregroundColor(service.iconColor)
                .frame(width: 40, height: 40)
                .background(service.iconColor.opacity(0.2))
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(service.name)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                if !service.description.isEmpty {
                    Text(service.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
