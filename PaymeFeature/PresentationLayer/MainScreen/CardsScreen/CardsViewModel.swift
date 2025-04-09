//
//  CardsViewModel.swift
//  PaymeFeature
//
//  Created by Samandar on 08/04/25.
//

import SwiftUI


class CardsViewModel: ObservableObject {
    
    @Published var cards: [BankCard] = []
    
    
    init() {
        
        loadCards()
        
    }
    
    
    func loadCards() {
        
        cards = [
            BankCard(
                name: "Student Card",
                ownerName: "Samandar Toshpulatov",
                sum: "1200",
                cardNumber: "4444 3333 2222 1111",
                type: .visa,
                expirationDate: "09/25",
                cardColor: .purple,
                iconName: "creditcard.fill"
            ),
            BankCard(
                name: "Shopping Card",
                ownerName: "Samandar Toshpulatov",
                sum: "430",
                cardNumber: "5555 6666 7777 8888",
                type: .uzcard,
                expirationDate: "03/28",
                cardColor: .paymeC
            ),
            BankCard(
                name: "Salary Card",
                ownerName: "Samandar Toshpulatov",
                sum: "3200",
                cardNumber: "9999 8888 7777 6666",
                type: .humo,
                expirationDate: "01/26",
                cardColor: .indigo,
                iconName: "creditcard.viewfinder",
                isFamilyCard: true
            )
        ]
        
    }
    
}
