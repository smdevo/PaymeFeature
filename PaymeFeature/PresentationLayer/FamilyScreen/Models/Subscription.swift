//
//  Subscription.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 07/04/25.
//

import Foundation

struct Subscription: Codable, Identifiable {
    let id: String
    let name: String
    let price: Double
    let renewalDate: Date
}
