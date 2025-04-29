//
//  AuthScreen.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI
import LocalAuthentication
import Combine

class FamilyViewModel: ObservableObject {
    
    let networkingService = UsersNtworkinDataService.shared
    
    private var timerCancellable: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    
    @Published var currentUser: UserModel?
    
    @Published var familyMembers: [UserModel] = []
    
    @Published var allUsers: [UserModel] = []
    
    @Published var familyCards: [VirtualCardModel] = []
    
    
    @Published var userId = UserDefaults.standard.string(forKey: "userId") ?? "1"
    @Published var userFamilyId = UserDefaults.standard.string(forKey: "userFamilyId") ?? "1"
    
    init() {
        getCurrentUserAndFamily()
        
        startTimer()
    }
    
    
    private func startTimer() {
            timerCancellable = Timer.publish(every: 5, on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] _ in
                    self?.getCurrentUserAndFamily()
                }
        }
    
    deinit {
        timerCancellable?.cancel()
    }
    
    func gettingMembers() {
        
        familyMembers = allUsers.filter({$0.familyId == currentUser?.familyId})
        
    }
    
    func getCurrentUserAndFamily() {
        
        networkingService.getData(link: "users/") { [weak self] (users: [UserModel]?) in
            guard let users else { return }
            self?.allUsers = users
            self?.currentUser = users.first(where: {$0.id == self?.userId})
                     
            self?.familyMembers = users.filter({$0.familyId == self?.currentUser?.familyId})
        }
        
        networkingService.getData(link: "childCards/" + userFamilyId) { [weak self] (family: FamilyModel?) in
            guard let family = family else { return }
            
            self?.familyCards = family.cards.compactMap { $0 }
        }
        
    }
    
    func addUserToFamily(phoneNumber: String, adminUser: UserModel, completion: @escaping (Bool) -> Void) {
        
        let usersEndpoint = "users?number=\(phoneNumber)"
        
        UsersNtworkinDataService.shared.getData(link: usersEndpoint) { (users: [UserModel]?) in
            guard let users = users, let userToUpdate = users.first else {

                completion(false)
                return
            }
            
            if userToUpdate.familyId == adminUser.familyId {

                completion(false)
                return
            }
            
            
            var updatedUser = userToUpdate
            updatedUser.familyId = adminUser.familyId
            
            
            
            UserDefaults.standard.set(updatedUser.familyId, forKey: "userFamilyId")
            
            let userUpdateEndpoint = "users/\(updatedUser.id)"
            
            UsersNtworkinDataService.shared.updateData(link: userUpdateEndpoint, dataToUpdate: updatedUser) { success in
                if success {
                    
                    let familyEndpoint = "childCards/\(adminUser.familyId)"
                    UsersNtworkinDataService.shared.getData(link: familyEndpoint) { (family: FamilyModel?) in
                        guard let familyToUpdate = family else {
                            completion(false)
                            return
                        }
                        
                        
                        UsersNtworkinDataService.shared.updateData(link: familyEndpoint, dataToUpdate: familyToUpdate) { familyUpdateSuccess in
                        
                            completion(familyUpdateSuccess)
                        }
                    }
                } else {
                    
                    completion(false)
                }
            }
        }
        refreshData()
    }
    
    
    func addFamilyCard(cardName: String, ownerPhoneNumber: String, completion: @escaping (Bool) -> Void) {
        guard let familyId = currentUser?.familyId else {
            
            completion(false)
            return
        }
        
        let familyEndpoint = "childCards/\(familyId)"
        
        UsersNtworkinDataService.shared.getData(link: familyEndpoint) { (family: FamilyModel?) in
            guard var familyToUpdate = family else {
                
                completion(false)
                return
            }
            
            let digits = (0..<16).compactMap { _ in "0123456789".randomElement() }
            let rawCardNumber = String(digits)
            var formattedCardNumber = ""
            for (index, digit) in rawCardNumber.enumerated() {
                if index != 0 && index % 4 == 0 {
                    formattedCardNumber.append(" ")
                }
                formattedCardNumber.append(digit)
            }
            
            let newCard = VirtualCardModel(
                id: ownerPhoneNumber,
                name: cardName,
                number: formattedCardNumber,
                ownerPhoneNumber: self.currentUser?.number ?? "" ,
                balance: "0",
                limit: nil
            )
            
            familyToUpdate.cards.append(newCard)
            
            UsersNtworkinDataService.shared.updateData(link: familyEndpoint, dataToUpdate: familyToUpdate) { success in
                completion(success)
            }
        }
        refreshData()
    }
    
    
    
    
    func sendInvitation(phoneNumber: String, adminUser: UserModel, completion: @escaping (Bool) -> Void) {
        let usersEndpoint = "/users?number=\(phoneNumber)"
        
        UsersNtworkinDataService.shared.getData(link: usersEndpoint) { (users: [UserModel]?) in
            guard let users = users, var userToInvite = users.first else {
                completion(false)
                return
            }
            
            userToInvite.invitation = true
            userToInvite.invitedFamilyId = adminUser.familyId
            
            let userUpdateEndpoint = "/users/\(userToInvite.id)"
            UsersNtworkinDataService.shared.updateData(link: userUpdateEndpoint, dataToUpdate: userToInvite) { success in
                completion(success)
            }
        }
        refreshData()
    }
    
    func confirmInvitation(enteredCode: String, completion: @escaping (Bool) -> Void) {
        guard enteredCode == "123456",
              var current = currentUser,
              let invitedFamilyId = current.invitedFamilyId else {
            completion(false)
            return
        }
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Подтвердите вашу личность с помощью Face ID для подтверждения приглашения"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        current.familyId = invitedFamilyId
                        current.invitation = false
                        current.invitedFamilyId = nil
                        
                        let userUpdateEndpoint = "/users/\(current.id)"
                        UsersNtworkinDataService.shared.updateData(link: userUpdateEndpoint, dataToUpdate: current) { updateSuccess in
                            if updateSuccess {
                                self.currentUser = current
                                completion(true)
                            } else {
                                completion(false)
                            }
                        }
                    } else {
                        
                        completion(false)
                    }
                }
            }
        } else {
            
            completion(false)
        }
        refreshData()
    }
    
    
    func refreshData() {
        networkingService.getData(link: "users/") { [weak self] (users: [UserModel]?) in
            guard let self = self, let users = users else { return }
            DispatchQueue.main.async {
                
                UserDefaults.standard.removeObject(forKey: "userFamilyId")
                UserDefaults.standard.set(self.currentUser?.familyId ?? "1", forKey: "userFamilyId")
                
                self.userFamilyId = self.currentUser?.familyId ?? "1"
                
                self.currentUser = users.first(where: { $0.id == self.userId })
                self.familyMembers = users.filter({ $0.familyId == self.currentUser?.familyId })
            }
        }
        
        networkingService.getData(link: "childCards/" + userFamilyId) { [weak self] (family: FamilyModel?) in
            guard let self = self, let family = family else { return }
            DispatchQueue.main.async {
                self.familyCards = family.cards.compactMap { $0 }
            }
        }
    }
    
}



