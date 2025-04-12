//
//  CardsTableView.swift
//  PaymeFeature
//
//  Created by Samandar on 08/04/25.
//

import SwiftUI

struct CardsTableView: View {
    
    var cards: [BankCard]
    
    init(cards: [BankCard]) {
        self.cards = cards
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(cards) { card in
                        CardView(bankCard: card)
                            .padding()
                }
                
            }
        }
    }
}

#Preview {
    CardsTableView(cards: [
        BankCard(
            name: "Student Card",
            ownerName: "Samandar Toshpulatov",
            sum: "1200",
            cardNumber: "4444 3333 2222 1111",
            type: .visa,
            expirationDate: "09/25",
            iconName: "creditcard.fill"
        ),
    ])
}
