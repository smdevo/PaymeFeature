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

