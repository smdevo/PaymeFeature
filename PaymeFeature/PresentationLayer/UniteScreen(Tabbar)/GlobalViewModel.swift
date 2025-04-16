//
//  CardsViewModel.swift
//  PaymeFeature
//
//  Created by Samandar on 08/04/25.
//

import SwiftUI

class GlobalViewModel: ObservableObject {
    
    @Published var currentUser: UserModel?
    
    @Published var currentFamily: FamilyModel?
    
    @Published var cards: [BankCard] = []
    
    @Published var transactions: [TransactionModel] = [
        TransactionModel(date: "9 апреля 2025", time: "12:34", amount: "300000", description: "перевод и услуги"),
        TransactionModel(date: "8 апреля 2025", time: "11:22", amount: "500000", description: "перевод и услуги")
    ]
    
    let netService = UsersNtworkinDataService.shared
    
    @Published var userID = UserDefaults.standard.string(forKey: "userId") ?? "1"
    @Published var familyId = UserDefaults.standard.string(forKey: "userFamilyId") ?? "1"
    
    init() {
        loadUserAndFamily()
    }
    
    func loadUserAndFamily() {
        let group = DispatchGroup()
        
        group.enter()
        netService.getData(link: "users/" + userID) { [weak self] (user: UserModel?) in
            DispatchQueue.main.async {
                self?.currentUser = user
                group.leave()
            }
        }
        
        group.enter()
        netService.getData(link: "childCards/" + familyId) { [weak self] (family: FamilyModel?) in
            DispatchQueue.main.async {
                self?.currentFamily = family
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            
            self.cards.removeAll()
            self.getbalanceCard()
            self.getFamilyCard()
        }
    }
    
    
    
    func getbalanceCard() {
        
        guard let currentUser else { return }
        
        let cardUser = BankCard(name: "Own Card", ownerName: currentUser.name, sum: currentUser.balance, cardNumber: currentUser.cardNumber, type: .uzcard, expirationDate: "11/28")
        
        cards.append(cardUser)
    }
    
    
    func getFamilyCard() {
        
        guard let currentFamily = currentFamily, let currentUser = currentUser else {
            print("Skipping getFamilyCard — missing data")
            return
        }
    
        let cards = currentUser.role ?
        currentFamily.cards :
        currentFamily.cards.filter({ cCard in
            cCard?.id == currentUser.number
        })
        
        let bankCards = cards.map { fCard in
            
            BankCard(name: fCard?.name ?? "Name", ownerName: currentUser.name, sum: fCard?.balance ?? "Balance", cardNumber: fCard?.number ?? "Number", type: .humo, expirationDate: "11/28",isFamilyCard: true)
        }
        
        self.cards.append(contentsOf: bankCards)
    }
    
    
    func sendMoney(amount: String, completion: @escaping (Bool) -> Void) {
        
        guard let amountSum = Double(amount), amountSum > 0 else {
            completion(false)
            return
        }
        
        guard let currentUser = currentUser, let currentFamily = currentFamily else {
            completion(false)
            return
        }
        
        guard
            let userSum = Double(currentUser.balance),
            let card = currentFamily.cards.first,
            let famBalance = card?.balance,
            
            let famCardSum = Double(famBalance)
        else {
            completion(false)
            return
        }
        
        
        let isParent = currentUser.role
        
        guard
            isParent ? userSum > amountSum : famCardSum > amountSum
        else {
            completion(false)
            return
        }
       
        
        let updatedUserBalance = isParent ?
        String(userSum - amountSum) : String(userSum + amountSum)
        
        let updatedFamilyBalance = isParent ?
        String(famCardSum + amountSum) : String(famCardSum - amountSum)
        
        let updatedUser = UserModel(
            name: currentUser.name,
            number: currentUser.number,
            password: currentUser.password,
            date: currentUser.date,
            familyId: currentUser.familyId,
            role: currentUser.role,
            balance: updatedUserBalance,
            id: currentUser.id,
            invitation: currentUser.invitation,
            cardNumber: currentUser.cardNumber
        )
        
        guard let famCard = currentFamily.cards.first else {
            return
        }
        
        let updatedFamily = FamilyModel(cards: [
            VirtualCardModel(
                id: famCard?.id ?? "",
                name: famCard?.name ?? "",
                number: famCard?.number ?? "",
                ownerPhoneNumber: famCard?.ownerPhoneNumber ?? "",
                balance: updatedFamilyBalance
            )
        ], id: currentFamily.id)
        
        
        let group = DispatchGroup()
        var successUserUpdate = false
        var successFamilyUpdate = false
        
        group.enter()
        netService.updateData(link: "users/" + userID, dataToUpdate: updatedUser) { res1 in
            successUserUpdate = res1
            group.leave()
        }
        
        group.enter()
        netService.updateData(link: "childCards/" + familyId, dataToUpdate: updatedFamily) { res2 in
            successFamilyUpdate = res2
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            completion(successUserUpdate && successFamilyUpdate)
            
            self?.saveHistoryMonitoring(sender: currentUser.cardNumber, receiver: famCard?.number ?? "", amount: String(amountSum))
            
            self?.cards.removeAll()
            self?.loadUserAndFamily()
        }
    }
    
    
    
    func saveHistoryMonitoring(sender: String, receiver: String, amount: String) {
        transactions.append(TransactionModel(date: "date", time: "date", amount: amount, description: "Transaction to family card"))
    }
    
    
    
}


