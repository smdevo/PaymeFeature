//
//  AuthScreen.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import Foundation

struct Transaction: Codable, Identifiable {
    let id: String
    let fromUserID: String
    let toUserID: String
    let amount: Double
    let date: Date
    let description: String
}
