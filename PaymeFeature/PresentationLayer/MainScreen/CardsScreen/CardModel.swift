//
//  CardModel.swift
//  PaymeFeature
//
//  Created by Samandar on 08/04/25.
//

import SwiftUI

struct BankCard: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let ownerName: String
    let sum: String
    let cardNumber: String
    let type: CardType
    let expirationDate: String
    let cardColor: Color
    let iconName: String
    let isFamilyCard: Bool
    
    
    init(name: String,
         ownerName: String,
         sum: String,
         cardNumber: String,
         type: CardType,
         expirationDate: String,
         cardColor: Color = Color(.green),
         iconName: String = "star.fill",
         isFamilyCard: Bool = false
    ) {
        self.name = name
        self.ownerName = ownerName
        self.sum = sum
        self.cardNumber = cardNumber
        self.type = type
        self.expirationDate = expirationDate
        self.cardColor = cardColor
        self.iconName = iconName
        self.isFamilyCard = isFamilyCard
    }
}
