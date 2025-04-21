//
//  CardModel.swift
//  PaymeFeature
//
//  Created by Samandar on 08/04/25.
//

import SwiftUI

struct BankCard: Identifiable {
    let id: String
    let name: String
    let ownerName: String
    let sum: String
    let cardNumber: String
    let type: CardType
    let expirationDate: String
    let iconName: String
    let isFamilyCard: Bool
    let limit: String?

    
    init(name: String,
         ownerName: String,
         sum: String,
         cardNumber: String,
         type: CardType,
         expirationDate: String,
         iconName: String = "star.fill",
         isFamilyCard: Bool = false,
         id: String,
         limit: String?
    ) {
        self.name = name
        self.ownerName = ownerName
        self.sum = sum
        self.cardNumber = cardNumber
        self.type = type
        self.expirationDate = expirationDate
        self.iconName = iconName
        self.isFamilyCard = isFamilyCard
        self.id = id
        self.limit = limit  
    }
}
