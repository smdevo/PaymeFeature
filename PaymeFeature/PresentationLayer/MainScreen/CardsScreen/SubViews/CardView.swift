//
//  CardView.swift
//  PaymeFeature
//
//  Created by Samandar on 08/04/25.
//

import SwiftUI

struct CardView: View {
    
    let bankCard: BankCard
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: bankCard.iconName)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.blue)
                    .clipShape(Circle())

                Spacer()
                
                VStack(alignment: .leading) {
                    Text(bankCard.type.rawValue)
                        .font(.title)

                }
                Spacer()
                
            }
            .overlay(alignment: .trailing) {
                if bankCard.isFamilyCard {
                    
                    Image(systemName: "figure.and.child.holdinghands")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                    
                }
            }
            
            Text("\(bankCard.sum) so'm")
                .font(.title)

            
            
            Text(bankCard.ownerName)
                    .font(.title2)
         
            
            HStack {
                Text(bankCard.cardNumber)
                    .font(.callout)
                
                Spacer()
                
                Text(bankCard.expirationDate)
                    .font(.callout)
                Spacer()
            }
            
        }
        .padding()
        .background(bankCard.cardColor)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        .foregroundStyle(.white)
        
    }
}

#Preview {
    VStack {
        CardView(bankCard: BankCard(name: "Aloqabank", ownerName: "Samandar Toshpulatov", sum: 60400, cardNumber: "7789098756432118", type: .uzcard,expirationDate: "11/25"))
            .padding()
    }
    .background(Color(.systemGroupedBackground))
}

