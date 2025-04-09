//
//  FriendsView.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

struct FamilyView: View {
    @ObservedObject var viewModel: FamilyViewModel = FamilyViewModel()
    
    @State private var showFamilyCardAddSheet: Bool = false
    @State private var showAddFamilyMemberSheet: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        
                        ForEach(viewModel.familyMembers) { member in
                            VStack {
                                Circle()
                                    .fill(member.role ? Color.green : Color.blue)
                                    .frame(width: 60, height: 60)
                                    .overlay(
                                        Text(String(member.name.prefix(1)))
                                            .foregroundColor(.white)
                                            .font(.title)
                                    )
                                Text(member.name)
                                    .font(.caption)
                            }
                        }//Foreach
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                if let user = viewModel.currentUser,
                    user.role {
                    Button(action: {
                        showFamilyCardAddSheet = true
                    }) {
                        Text("Заказать виртуальную карту")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
            .navigationTitle("Моя семья")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showFamilyCardAddSheet) {
                FamilyCardAddView()
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.hidden)
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if let user = viewModel.currentUser,
                       user.role  {
                        Button(action: {
                            showAddFamilyMemberSheet.toggle()
                        }) {
                            Image(systemName: "plus.circle")
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddFamilyMemberSheet) {
                AddFamilyMember()
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.hidden)
            }
        }
    }
}    
    
//    struct FamilyViewContainer: View {
//        @ObservedObject var authManager = LoginManager.shared
//        
//        var body: some View {
//            if let currentUser = authManager.loggedNetUser {
//                let familyVM = FamilyViewModel(currentUser: currentUser, allUsers: authManager.users)
//                FamilyView(viewModel: familyVM)
//            } else {
//                Text("Пожалуйста, войдите, чтобы увидеть семью")
//                    .foregroundColor(.gray)
//            }
//        }
//    }
