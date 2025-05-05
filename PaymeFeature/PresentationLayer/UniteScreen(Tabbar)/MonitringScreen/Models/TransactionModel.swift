//
//  TransactionModel.swift
//  PaymeFeature
//
//  Created by Samandar on 30/04/25.
//

import Foundation

struct TransactionModel: Identifiable {
    let id = UUID()
    let date: String
    let time: String
    let amount: String
    let description: String
    let iconName: String?
    let category: String?
}
