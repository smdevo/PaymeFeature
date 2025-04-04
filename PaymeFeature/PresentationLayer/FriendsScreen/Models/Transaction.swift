//
//  AuthScreen.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import Foundation

struct Transaction: Identifiable, Codable {
    let id: UUID
    let fromCardNumber: String
    let toCardNumber: String
    let amount: Double
    let description: String
    let date: Date
}
