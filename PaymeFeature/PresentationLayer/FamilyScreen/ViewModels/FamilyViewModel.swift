//
//  AuthScreen.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

class FamilyViewModel: ObservableObject {
    
    @Published var currentUser: UserModel?
    
    @Published var familyMembers: [UserModel] = []
    
    @Published var familyCard: VirtualCardModel?
    
    
    
    init() {
        UsersNtworkinDataService.shared.fetchUsers { [weak self] users in
            guard let users else { return }
            
            let id = UserDefaults.standard.string(forKey: "idUser") ?? "4"
            
            self?.currentUser = users.first(where: {$0.id == id})
            self?.familyMembers = users.filter({$0.familyId == self?.currentUser?.familyId})
            }
        
        UsersNtworkinDataService.shared.fetchFamilies { [weak self] families in
            guard let families else { return }
    
            self?.familyCard = families.filter({$0.id == self?.currentUser?.familyId}).first?.virtualcard
            print("FAM CARD: : \(self?.familyCard?.name)")
        }
    }

}

