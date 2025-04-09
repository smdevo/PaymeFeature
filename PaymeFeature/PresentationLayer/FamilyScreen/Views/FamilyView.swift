
//
//  FamilyView.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

struct FamilyView: View {
    @StateObject var viewModel: FamilyViewModel
    @State private var showFamilyCardAddSheet: Bool = false
    @State private var showAddFamilyMemberSheet: Bool = false

    
    var familyCards: [BankCard] = [
           BankCard(
               name: "Personal Debit Card",
               ownerName: "Alice Johnson",
               sum: 2500,
               cardNumber: "1111 2222 3333 4444",
               type: .uzcard,
               expirationDate: "12/25",
               cardColor: Color.green,
               iconName: "creditcard.fill",
               isFamilyCard: true
           ),
           BankCard(
               name: "Family Virtual Card",
               ownerName: "Johnson Family",
               sum: 5000,
               cardNumber: "5555 4444 3333 2222",
               type: .uzcard,
               expirationDate: "11/26",
               cardColor: Color.blue,
               iconName: "house.fill",
               isFamilyCard: true
           ),
           BankCard(
               name: "Business Credit Card",
               ownerName: "Alice Johnson",
               sum: 10000,
               cardNumber: "7777 8888 9999 0000",
               type: .mastercard,
               expirationDate: "10/27",
               cardColor: Color.purple,
               iconName: "briefcase.fill",
               isFamilyCard: true
           )
       ]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(viewModel.familyMembers) { member in
                            VStack {
                                Circle()
                                    .fill(member.role == "parent" ? Color.green : Color.blue)
                                    .frame(width: 60, height: 60)
                                    .overlay(
                                        Text(String(member.name.prefix(1)))
                                            .foregroundColor(.white)
                                            .font(.title)
                                    )
                                Text(member.name)
                                    .font(.caption)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                

                if viewModel.hasPendingInvitation {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.yellow)
                        Text("Вас приглашают в семью")
                            .font(.subheadline)
                            .foregroundColor(.orange)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                                      VStack(spacing: 16) {
                                          ForEach(familyCards) { card in
                                              CardView(bankCard: card)
                                          }
                                      }
                                      .padding()
                                  }
                }
                
                Spacer()
                
//                if viewModel.currentUser.role == "parent" {
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
//                }
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
//                    if viewModel.currentUser.role == "parent" {
                        Button(action: {
                            showAddFamilyMemberSheet.toggle()
                        }) {
                            Image(systemName: "plus.circle")
                        }
//                    }
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

struct FamilyViewContainer: View {
    @ObservedObject var authManager = LoginManager.shared

    var body: some View {
        if let currentUserModel = authManager.loggedNetUser {
            let convertedUser = User(
                id: currentUserModel.id,
                name: currentUserModel.name,
                age: 0,
                balance: Double(currentUserModel.balance) ?? 0.0,
                userName: currentUserModel.number,
                password: currentUserModel.password,
                date: TimeInterval(currentUserModel.date),
                friends: [],
                cardNumber: nil,
                avatar: nil,
                role: currentUserModel.role ? "parent" : "child",
                cards: [],
                transactions: [],
                subscriptions: []
            )
            
            let convertedUsers = authManager.netUsers.map { userModel in
                User(
                    id: userModel.id,
                    name: userModel.name,
                    age: 0,
                    balance: Double(userModel.balance) ?? 0.0,
                    userName: userModel.number,
                    password: userModel.password,
                    date: TimeInterval(userModel.date),
                    friends: [],
                    cardNumber: nil,
                    avatar: nil,
                    role: userModel.role ? "parent" : "child",
                    cards: [],
                    transactions: [],
                    subscriptions: []
                )
            }
            
            let familyVM = FamilyViewModel(currentUser: convertedUser, allUsers: convertedUsers)
            FamilyView(viewModel: familyVM)
        } else {
            Text("Пожалуйста, войдите, чтобы увидеть семью")
                .foregroundColor(.gray)
        }
    }
}


