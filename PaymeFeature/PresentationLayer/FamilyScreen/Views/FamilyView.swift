
//
//  FamilyView.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

struct FamilyView: View {
    
    
    @StateObject var viewModel: FamilyViewModel = FamilyViewModel()
    
    @EnvironmentObject var vm: GlobalViewModel
    
    
    @State private var showFamilyCardAddSheet: Bool = false
    @State private var showAddFamilyMemberSheet: Bool = false
    
    @State private var showInvitationAlert: Bool = false
    @State private var invitationCode: String = ""

    var familyCards: [BankCard] = []
    
    var body: some View {
        NavigationView {
            
            if viewModel.currentUser == nil {
                ProgressView()
            }else {
                
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
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    if let user = viewModel.currentUser, user.invitation {
                        Button(action: {
                            showInvitationAlert = true
                        }) {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.yellow)
                                Text("Подтвердите приглашение в семью")
                                    .font(.subheadline)
                                    .foregroundColor(.orange)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        }
                        .alert("Подтверждение приглашения", isPresented: $showInvitationAlert) {
                            TextField("Введите код", text: $invitationCode)
                            Button("Confirm") {
                                viewModel.confirmInvitation(enteredCode: invitationCode) { success in
                                    if success {
                                        print("Success")
                                    } else {
                                        print("Failure")
                                    }
                                }
                            }
                            Button("Cancel", role: .cancel) { }
                        } message: {
                            Text("Введите код подтверждения, который вы получили")
                        }
                    }
                    else {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 16) {
                                ForEach(viewModel.familyCards, id: \.id) { card in
                                    CardView(bankCard:
                                                BankCard(
                                                    name: card.name,
                                                    ownerName: card.name,
                                                    sum: card.balance,
                                                    cardNumber: card.number,
                                                    type: .humo,
                                                    expirationDate: "11/27",
                                                    isFamilyCard: true))
                                    .environmentObject(viewModel)
                                }
                            }
                            .padding()
                        }

                    }
                    
                    Spacer()
                    
                    if let user = viewModel.currentUser, user.role {
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
                .background(.backgroundC)
                .sheet(isPresented: $showAddFamilyMemberSheet) {
                    AddFamilyMember(viewModel: viewModel)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.hidden)
                }
                .sheet(isPresented: $showFamilyCardAddSheet) {
                    FamilyCardAddView(viewModel: viewModel)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.hidden)
                }
            }
        }.onAppear{
            viewModel.refreshData()
        }
        .refreshable{
            viewModel.refreshData()
        }
        .navigationTitle("Моя семья")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                if let user = viewModel.currentUser {
                    Button(action: {
                        //TODO: 
                        //Change role
                    }) {
                        Image(systemName: user.role ? "person.fill" : "person")
                    }
                    
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                if let user = viewModel.currentUser, user.role {
                    Button(action: {
                        showAddFamilyMemberSheet.toggle()
                    }) {
                        Image(systemName: "plus.circle")
                    }
                    
                }
            }
           
        }
      
    }
}


