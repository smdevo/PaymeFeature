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
    
    @Published var familyCard: VirtualCardModel?
    
    let userId = UserDefaults.standard.string(forKey: "userId") ?? "1"
    let userFamilyId = UserDefaults.standard.string(forKey: "userFamilyId") ?? "1"
    
    
    
    init() {
        getCurrentUserAndFamily()
    }
    
    
    
    func getCurrentUserAndFamily() {
        
        UsersNtworkinDataService.shared.getData(link: "users/") { [weak self] (users: [UserModel]?) in
            guard let users else { return }
            self?.currentUser = users.first(where: {$0.id == self?.userId})
            self?.familyMembers = users.filter({$0.familyId == self?.currentUser?.familyId})
        }
        
        
        UsersNtworkinDataService.shared.getData(link: "families/" + userFamilyId) { [weak self] (family: FamilyModel?) in
            guard let family else { return }
                
            self?.familyCard = family.virtualcard
            }
        
    }
    
    

}

