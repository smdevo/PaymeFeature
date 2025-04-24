//
//  CardsTableView.swift
//  PaymeFeature
//
//  Created by Samandar on 08/04/25.
//

import SwiftUI

struct CardsTableView: View {
    
    @EnvironmentObject var vm: GlobalViewModel
    
    var cards: [BankCard]
    
    init(cards: [BankCard]) {
        self.cards = cards
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(cards) { card in
                    
                    if card.isFamilyCard {
                        ChildCardView(bankCard: card)
                    }else {
                        if vm.currentUser?.role ?? true {
                            CardView(bankCard: card)

                        }
                    }
                }
                
            }
        }
    }
}

