//
//  Subscription.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 07/04/25.
//


import Foundation

struct Card: Codable, Identifiable, Equatable {
    let id: String
    let cardNumber: String
    let expiryDate: String
    let phoneNumber: String
     
}
