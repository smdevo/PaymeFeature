//
//  CardsViewModel.swift
//  PaymeFeature
//
//  Created by Samandar on 08/04/25.
//

import SwiftUI
import Combine

class GlobalViewModel: ObservableObject {
    
    private var timerCancellable: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    
    @Published var currentUser: UserModel?
    
    @Published var currentFamily: FamilyModel?
    
    @Published var cards: [BankCard] = []
    
    
    //MARK: Limits
    
    @Published var limits: [String: Int] = [:]
    
    @Published var backgroundImange:  [String: String] = [:]
    
    
    let netService = UsersNtworkinDataService.shared
    
    @Published var userID = UserDefaults.standard.string(forKey: "userId") ?? "1"
    @Published var familyId = UserDefaults.standard.string(forKey: "userFamilyId") ?? "1"
    
    init() {
        loadUserAndFamily()
        startTimer()
    }
    
    private func startTimer() {
            timerCancellable = Timer.publish(every: 5, on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] _ in
                    self?.loadUserAndFamily()
                }
        }
    
    deinit {
        
        timerCancellable?.cancel()
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
            
            UserDefaults.standard.removeObject(forKey: "userFamilyId")
            UserDefaults.standard.set(self.currentUser?.familyId ?? "1", forKey: "userFamilyId")
            
            self.familyId = self.currentUser?.familyId ?? "1"
            
            self.cards.removeAll()
            self.getbalanceCard()
            self.getFamilyCard()
        }
    }
    
    
    
    func getbalanceCard() {
        
        guard let currentUser else { return }
        
        let cardUser = BankCard(name: "Own Card", ownerName: currentUser.name, sum: currentUser.balance, cardNumber: currentUser.cardNumber, type: .humo, expirationDate: "11/29", id: UUID().uuidString, limit: nil)
        
        cards.append(cardUser)
    }
    
    
    func getFamilyCard() {
        
        guard let currentFamily = currentFamily, let currentUser = currentUser else {
            return
        }
    
        let cards = currentUser.role ?
        currentFamily.cards :
        currentFamily.cards.filter({ cCard in
            cCard?.id == currentUser.number
        })
        
        let bankCards = cards.map { fCard in
            
            BankCard(name: fCard?.name ?? "Name", ownerName: currentUser.name, sum: fCard?.balance ?? "Balance", cardNumber: fCard?.number ?? "0000 0000 0000 0001", type: .uzcard, expirationDate: "11/28",isFamilyCard: true, id: fCard?.id ?? "1234", limit: fCard?.limit)
        }
        
        self.cards.append(contentsOf: bankCards)
    }
    
    
    func sendMoney(amount: String, number: String, completion: @escaping (Bool) -> Void) {
        
        guard let amountSum = Int(amount), amountSum > 0 else {
            completion(false)
            return
        }
        
        guard let currentUser = currentUser, let currentFamily = currentFamily else {
            completion(false)
            return
        }
        
        guard
            let userSum = Int(currentUser.balance),
            let card = currentFamily.cards.filter({$0?.id == number}).first,
            let famBalance = card?.balance,
            let famCardSum = Int(famBalance)
        else {
            completion(false)
            return
        }
        
        
        
        
        guard
            userSum > amountSum
        else {
            completion(false)
            return
        }
       
        let updatedUserBalance = String(userSum - amountSum)
        
        let updatedFamilyBalance = String(famCardSum + amountSum)
        
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
        
        guard let famCard = currentFamily.cards.filter({$0?.id == number}).first else {
            return
        }
        
        let updatedCard = VirtualCardModel(
            id: famCard?.id ?? "",
            name: famCard?.name ?? "",
            number: famCard?.number ?? "",
            ownerPhoneNumber: famCard?.ownerPhoneNumber ?? "",
            balance: updatedFamilyBalance,
            limit: famCard?.limit ?? ""
        )
        
        let cards = currentFamily.cards.map { vc in
            if vc?.id == updatedCard.id {
                updatedCard
            }else {
                vc
            }
        }
        
        let updatedFamily = FamilyModel(cards: cards, id: currentFamily.id)
        
        
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
            
//            self?.saveHistoryMonitoring(sender: currentUser.cardNumber, receiver: famCard?.number ?? "", amount: String(amountSum))
            
            self?.cards.removeAll()
            self?.loadUserAndFamily()
        }
    }
    
    
    
//    func saveHistoryMonitoring(sender: String, receiver: String, amount: String) {
//        transactions.append(TransactionModel(date: "Сегодня", time: "15:22", amount: amount, description: "Перевод", iconName: "", category: "Оплата"))
//    }
    
    func setLimitToFamilyCard(id: String, limit: String) {
    
        guard let family = currentFamily else { return }
        
        let card = family.cards.filter { vcm in
            vcm?.id == id
        }.first
        
        guard let card else { return }
        
        let cardToSetLimit = VirtualCardModel(id: id, name: card?.name ?? "", number: card?.number ?? "", balance: card?.balance ?? "0", limit: limit)
        
        let cards = family.cards.map { vc in
            if vc?.id == cardToSetLimit.id {
                cardToSetLimit
            }else {
                vc
            }
        }
        
        let updatedFamily = FamilyModel(cards: cards, id: family.id)
        
        
        currentFamily = updatedFamily
        
        netService.updateData(link: "childCards/" + familyId, dataToUpdate: updatedFamily, completion: { (success) in
            if success {
                print("Successfully updated")
            } else {
                print("Failed to update")
            }
        })
    
        
        
    }
    
    
    
}


