//
//  AllFamilyMembersView.swift
//  PaymeFeature
//
//  Created by Umidjon on 21/04/25.
//

import SwiftUI


struct FamilyMembersView: View {
    let participants: [UserModel] = [
        
        UserModel(name: "Сардор Ашуров", number: "+998 99 111 23 34", password: "111", date: 111, familyId: "111", role: true, balance: "10000", id: "111", invitation: false, cardNumber: "1111 1111 1111 1111"),
        UserModel(name: "Акбар Равшанов", number: "+998 93 342 23 35", password: "222", date: 222, familyId: "222", role: false, balance: "10000", id: "222", invitation: false, cardNumber: "2222 2222 2222 2222"),
        UserModel(name: "Халилов Шухрат", number: "+998 91 147 02 24", password: "333", date: 333, familyId: "333", role: false, balance: "10000", id: "333", invitation: false, cardNumber: "333"),
        UserModel(name: "Азимов Азиз", number: "+998 90 235 21 98", password: "444", date: 444, familyId: "444", role: false, balance: "10000", id: "444", invitation: false, cardNumber: "444")
        
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Дети")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                if participants.isEmpty {
                    Text("No members found")
                        .foregroundColor(.gray)
                        .padding(.top, 100)
                } else {
                    ForEach(participants) { participant in
                        MembersInfo(participant: participant)
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.bottom, 30)
        }
        .background(
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
        )
        .navigationTitle("Дети")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    NavigationStack {
        FamilyMembersView()
    }
}
