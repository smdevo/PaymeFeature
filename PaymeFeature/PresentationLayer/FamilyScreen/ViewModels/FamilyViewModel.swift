//
//  AuthScreen.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

class FamilyViewModel: ObservableObject {
    
    let networkingService = UsersNtworkinDataService.shared
    
    @Published var currentUser: UserModel?
    
    @Published var familyMembers: [UserModel] = []

    @Published var allUsers: [UserModel] = []
    
    @Published var familyCard: VirtualCardModel?
    
    let userId = UserDefaults.standard.string(forKey: "userId") ?? "1"
    let userFamilyId = UserDefaults.standard.string(forKey: "userFamilyId") ?? "1"
    
    
    
    init() {
        getCurrentUserAndFamily()
    }
    
    
    
    func getCurrentUserAndFamily() {
        
        UsersNtworkinDataService.shared.getData(link: "users/") { [weak self] (users: [UserModel]?) in
            guard let users else { return }
            self?.allUsers = users
            self?.currentUser = users.first(where: {$0.id == self?.userId})
            self?.familyMembers = users.filter({$0.familyId == self?.currentUser?.familyId})
        }
        
            UsersNtworkinDataService.shared.getData(link: "families/" + userFamilyId) { [weak self] (family: FamilyModel?) in
            guard let family else { return }
                
            self?.familyCard = family.virtualcard
            }
        
    }

    
    
   
    func addUserToFamily(phoneNumber: String, adminUser: UserModel, completion: @escaping (Bool) -> Void) {
        let usersEndpoint = "/users?number=\(phoneNumber)"
        
        UsersNtworkinDataService.shared.getData(link: usersEndpoint) { (users: [UserModel]?) in
            guard let users = users, let userToUpdate = users.first else {
                print("Пользователь не найден для номера: \(phoneNumber)")
                completion(false)
                return
            }
            
            var updatedUser = userToUpdate
            updatedUser.familyId = adminUser.familyId
            
            let userUpdateEndpoint = "/users/\(updatedUser.id)"
            
            UsersNtworkinDataService.shared.updateData(link: userUpdateEndpoint, dataToUpdate: updatedUser) { success in
                if success {
                    let familyEndpoint = "/families/\(adminUser.familyId)"
                    UsersNtworkinDataService.shared.getData(link: familyEndpoint) { (family: FamilyModel?) in
                        guard var familyToUpdate = family else {
                            completion(false)
                            return
                        }
                        
                        if !familyToUpdate.members.contains(updatedUser.id) {
                            familyToUpdate.members.append(updatedUser.id)
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
    }

    
    func addFamilyCard(cardName: String, ownerPhoneNumber: String, completion: @escaping (Bool) -> Void) {
        guard let familyId = currentUser?.familyId else {
            completion(false)
            return
        }
        
        let familyEndpoint = "families/\(familyId)"
        
        UsersNtworkinDataService.shared.getData(link: familyEndpoint) { (family: FamilyModel?) in
            guard var familyToUpdate = family else {
                print("Семья с id \(familyId) не найдена")
                completion(false)
                return
            }
            
            let randomCardNumber = String((0..<16).map { _ in "0123456789".randomElement()! })
            
            let newCard = VirtualCardModel(
                id: UUID().uuidString,
                name: cardName,
                number: randomCardNumber,
                ownerPhoneNumber: ownerPhoneNumber,
                balance: "0"
            )
            
            if familyToUpdate.virtualcard == nil || familyToUpdate.virtualcard?.id.isEmpty == true {
                familyToUpdate.virtualcard = newCard
                UsersNtworkinDataService.shared.patchData(link: familyEndpoint, dataToUpdate: familyToUpdate) { success in
                    if success {
                        print("Семейная карта успешно создана")
                    } else {
                        print("Ошибка при создании семейной карты")
                    }
                    completion(success)
                }
            } else {
                familyToUpdate.virtualcard = newCard
                UsersNtworkinDataService.shared.patchData(link: familyEndpoint, dataToUpdate: familyToUpdate) { success in
                    if success {
                        print("Семейная карта успешно обновлена")
                    } else {
                        print("Ошибка при обновлении семейной карты")
                    }
                    completion(success)
                }
            }
        }
    }





    
    func refreshData() {
           UsersNtworkinDataService.shared.getData(link: "users/") { [weak self] (users: [UserModel]?) in
               guard let self = self, let users = users else { return }
               DispatchQueue.main.async {
                   self.currentUser = users.first(where: { $0.id == self.userId })
                   self.familyMembers = users.filter({ $0.familyId == self.currentUser?.familyId })
               }
           }
           
           UsersNtworkinDataService.shared.getData(link: "families/" + userFamilyId) { [weak self] (family: FamilyModel?) in
               guard let self = self, let family = family else { return }
               DispatchQueue.main.async {
                   self.familyCard = family.virtualcard
               }
           }
       }
    
    
}



