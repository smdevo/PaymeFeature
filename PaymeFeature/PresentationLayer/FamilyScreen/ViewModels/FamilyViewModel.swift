//
//  AuthScreen.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

class FamilyViewModel: ObservableObject {
    @Published var familyMembers: [User]
    var allUsers: [User]
    var currentUser: User
    
    init(currentUser: User, allUsers: [User]) {
        self.currentUser = currentUser
        self.allUsers = allUsers

        if currentUser.role == "child" {
            self.familyMembers = allUsers.filter { $0.role == "parent" }
        } else {
            self.familyMembers = currentUser.friends ?? []
        }
    }
    
    init() {
        self.currentUser = User(id: "0", name: "", age: 0, balance: 0.0, userName: "", password: "", date: 0, friends: [], cardNumber: nil, avatar: nil, role: "", transactions: [], subscriptions: [])
        self.familyMembers = []
        self.allUsers = []
    }
    
    func addFamilyMember(byCardNumber cardNumber: String) {
        guard !cardNumber.isEmpty else { return }
        if let member = allUsers.first(where: { $0.cardNumber == cardNumber }) {
            if !familyMembers.contains(where: { $0.id == member.id }) {
                familyMembers.append(member)
            }
        }
    }
    
    
    func sendMoney(to child: User, amount: Double) {
        guard currentUser.role == "parent" else {
            return
        }
        guard currentUser.balance >= amount else {
            return
        }
        
        currentUser.balance -= amount
        
        if let index = allUsers.firstIndex(where: { $0.id == child.id }) {
            allUsers[index].balance += amount
            
            let transaction = Transaction(
                id: UUID().uuidString,
                fromUserID: currentUser.id,
                toUserID: child.id,
                amount: amount,
                date: Date(),
                description: "Перевод денег от родителя"
            )
            
            if var existingTxns = allUsers[index].transactions {
                existingTxns.append(transaction)
                allUsers[index].transactions = existingTxns
            } else {
                allUsers[index].transactions = [transaction]
            }
        }
        
        if let famIndex = familyMembers.firstIndex(where: { $0.id == child.id }) {
            familyMembers[famIndex].balance += amount
            
            let txn = Transaction(
                id: UUID().uuidString,
                fromUserID: currentUser.id,
                toUserID: child.id,
                amount: amount,
                date: Date(),
                description: "Перевод денег от родителя"
            )
            
            if var existingTxns = familyMembers[famIndex].transactions {
                existingTxns.append(txn)
                familyMembers[famIndex].transactions = existingTxns
            } else {
                familyMembers[famIndex].transactions = [txn]
            }
        }
        
    }


    var childrenHistory: [HistoryItem] {
        let children = familyMembers.filter { $0.role == "child" }
        var items: [HistoryItem] = []
        for child in children {
            if let txns = child.transactions {
                for txn in txns {
                    items.append(.transaction(txn))
                }
            }
            if let subs = child.subscriptions {
                for sub in subs {
                    items.append(.subscription(sub))
                }
            }
        }
        items.sort { $0.date > $1.date }
        return items
    }
}

