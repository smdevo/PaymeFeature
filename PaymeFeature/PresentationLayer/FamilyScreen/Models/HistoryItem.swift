//
//  HistoryItem.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 07/04/25.
//

import Foundation

enum HistoryItem: Identifiable {
    case transaction(Transaction)
    case subscription(Subscription)
    
    var id: String {
        switch self {
        case .transaction(let txn):
            return "txn-\(txn.id)"
        case .subscription(let sub):
            return "sub-\(sub.id)"
        }
    }
    
    var date: Date {
        switch self {
        case .transaction(let txn):
            return txn.date
        case .subscription(let sub):
            return sub.renewalDate
        }
    }
}
