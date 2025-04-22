//
//  MembersInfoView.swift
//  PaymeFeature
//
//  Created by Umidjon on 21/04/25.
//

import SwiftUI


struct MembersInfo: View {
    let participant: UserModel
    
    var body: some View {
        HStack(spacing: 16) {
            
            ZStack {
                Circle()
                    .fill(Color.teal.opacity(0.15))
                    .frame(width: 60, height: 60)
                
                
                Image(participant.role ? "Parents" : "Child")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(participant.role ? .blue : .green)
                    .clipShape(Circle())
                
            }
            
            
            VStack(alignment: .leading, spacing: 4) {
                Text(participant.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                Text(participant.number)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(participant.role ? "Родитель" : "Ребёнок")
                    .font(.caption)
                    .foregroundColor(participant.role ? .blue : .green)
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.backgroundC)
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        )
    }
}

