
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
    
    @State private var showSnackbar: Bool = false
    @State private var snackbarMessage: String = ""
    
    var familyCards: [BankCard] = []
    
    var body: some View {
        ZStack{
            NavigationView {
                if viewModel.currentUser == nil {
                    ProgressView()
                }else {
                    VStack {
                        VStack {
                            HStack {
                                Circle()
                                    .fill(.backgroundC)
                                    .frame(width: 60, height: 60)
                                    .overlay(
                                        Image("familyImage")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60, height: 80)
                                    )
                                    .padding(.horizontal)
                                
                                VStack(alignment: .leading){
                                    Text("Детские карты")
                                        .fontWeight(.bold)
                                    Text("\(viewModel.familyMembers.count) участник")
                                }
                            }
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.paymeC.opacity(0.3))
                        .clipShape(.rect(cornerRadius: 12))
                        
                        if let user = viewModel.currentUser, user.invitation {
                            Button(action: {
                                showInvitationAlert = true
                            }) {
                                HStack {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .foregroundColor(.paymeC)
                                    Text("Подтвердите приглашение в семью")
                                        .font(.subheadline)
                                        .foregroundColor(.paymeC)
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                                .padding()
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
                                Button("Cancel", role: .cancel) {}
                            } message: {
                                Text("Введите код подтверждения, который вы получили")
                            }
                        }
                        Text("Детские карты")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fontWeight(.bold)
                            .padding()
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 12) {
                                if viewModel.currentUser?.role == true {
                                    ForEach(viewModel.familyCards, id: \.id) { card in
                                        ChildCardView(bankCard:
                                                        BankCard(
                                                            name: String(card.name.split(separator: " ").first ?? ""),
//                                                            name: card.name,
                                                            ownerName: card.name,
                                                            sum: card.balance,
                                                            cardNumber: card.number,
                                                            type: .humo,
                                                            expirationDate: "11/27",
                                                            isFamilyCard: true, id: card.id))
                                        .environmentObject(viewModel)
                                    }
                                }
                                else {
                                    let realCard = viewModel.familyCards.filter({ cardone in
                                        cardone.id == viewModel.currentUser?.number
                                    })
                                    if let card = realCard.first {
                                        ChildCardView(bankCard:
                                                    BankCard(
                                                        name: card.name,
                                                        ownerName: card.name,
                                                        sum: card.balance,
                                                        cardNumber: card.number,
                                                        type: .humo,
                                                        expirationDate: "11/27",
                                                        isFamilyCard: true, id: card.id))
                                        .environmentObject(viewModel)
                                    }
                                }
                                if let user = viewModel.currentUser, user.role {
                                    Button(action: {
                                        showFamilyCardAddSheet = true
                                    }) {
                                        HStack{
                                            
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(.paymeC)
                                                .frame(width: .spacing(.x14), height: .spacing(.x14))
                                                .overlay(
                                                    Image(systemName: "plus")
                                                        .foregroundColor(.white)
                                                        .fontWeight(.bold)
                                                )
                                            Text("Добавить детскую карту")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .padding()
                                                .cornerRadius(10)
                                        }
                                        
                                    }
                                    .padding()
                                }
                            }
                        }
                    }
                    
                    .padding()
                    .background(.backgroundC)
                    
                    .sheet(isPresented: $showAddFamilyMemberSheet) {
                        AddFamilyMember(viewModel: viewModel, showSnackbar: $showSnackbar, snackbarMessage: $snackbarMessage)
                            .presentationDetents([.medium])
                            .presentationDragIndicator(.hidden)
                    }
                    .sheet(isPresented: $showFamilyCardAddSheet) {
                        FamilyCardAddView(viewModel: viewModel, showSnackbar: $showSnackbar, snackbarMessage: $snackbarMessage)
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
                    if let user = viewModel.currentUser, user.role {
                        Button(action: {
                            showAddFamilyMemberSheet.toggle()
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundStyle(.paymeC)
                        }
                        
                    }
                }
            }
            
            if showSnackbar {
                VStack {
                    Spacer()
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.white)
                        Text(snackbarMessage)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.green)
                    .cornerRadius(12)
                    .padding(.bottom, 20)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .animation(.easeInOut(duration: 0.3), value: showSnackbar)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            showSnackbar = false
                        }
                    }
                }
            }
            
            
        }
    }
}

