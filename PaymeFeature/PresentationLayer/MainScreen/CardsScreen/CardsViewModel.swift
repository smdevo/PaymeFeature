//
//  CardsViewModel.swift
//  PaymeFeature
//
//  Created by Samandar on 08/04/25.
//

import SwiftUI


class CardsViewModel: ObservableObject {
    
    @Published var currentUser: UserModel?
    
    @Published var currentFamily: FamilyModel?
    
    @Published var cards: [BankCard] = []
    
    let netService = UsersNtworkinDataService.shared
    
    
    let userID = UserDefaults.standard.string(forKey: "userId") ?? "1"
    let familyId = UserDefaults.standard.string(forKey: "userFamilyId") ?? "1"
    
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
        netService.getData(link: "families/" + familyId) { [weak self] (family: FamilyModel?) in
            DispatchQueue.main.async {
                self?.currentFamily = family
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
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
        guard let cardFamily = currentFamily.virtualcard else {
            return
        }
        
        let familyCardUser = BankCard(name: cardFamily.name, ownerName: currentUser.name, sum: cardFamily.balance, cardNumber: cardFamily.number, type: .humo, expirationDate: "11/28",isFamilyCard: true)
        cards.append(familyCardUser)
    }
    
    
    func sendMoney(amount: String, completion: @escaping (Bool) -> Void) {
        
        guard let amountSum = Double(amount), amountSum > 0 else { return }
        guard let balance = currentUser?.balance, let userSum = Double(balance), amountSum < userSum else { return }
        guard let famBalance = currentFamily?.virtualcard?.balance, let famCardSum = Double(famBalance) else { return }
        guard let currentUser = currentUser, let currentFamily = currentFamily else { return }
        
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
        
        let famCard = currentFamily.virtualcard
        
        let updatedFamily = FamilyModel(
            name: currentFamily.name,
            members: currentFamily.members,
            virtualcard: VirtualCardModel(
                id: famCard?.id ?? "",
                name: famCard?.name ?? "",
                number: famCard?.number ?? "",
                ownerPhoneNumber: famCard?.ownerPhoneNumber ?? "",
                balance: updatedFamilyBalance
            ),
            id: currentFamily.id
        )
        
        let group = DispatchGroup()
        var successUserUpdate = false
        var successFamilyUpdate = false
        
        group.enter()
        netService.updateData(link: "users/" + userID, dataToUpdate: updatedUser) { res1 in
            successUserUpdate = res1
            group.leave()
        }
        
        group.enter()
        netService.updateData(link: "families/" + familyId, dataToUpdate: updatedFamily) { res2 in
            successFamilyUpdate = res2
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            completion(successUserUpdate && successFamilyUpdate)
            self?.cards.removeAll()
            self?.loadUserAndFamily()
        }
    }
    
}


