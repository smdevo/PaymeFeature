
//
//  FamilyView.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

struct FamilyView: View {
    
    
    @EnvironmentObject var viewModel: FamilyViewModel
        
    
    @State private var showAddFamilyMemberSheet: Bool = false
    
    @State private var showInvitationAlert: Bool = false
    @State private var invitationCode: String = ""
    
    @State private var showSnackbar: Bool = false
    @State private var snackbarMessage: String = ""
    
    var familyCards: [BankCard] = []
    
    var body: some View {
        
        let members = self.viewModel.familyMembers.filter { !$0.role }.count
        
        ZStack{
            if viewModel.currentUser == nil {
                ProgressView()
            }else {
                VStack {
                    
                    NavigationLink {
                        
                        FamilyMembersView(
                            viewModel: viewModel,
                            onCardAdded: {
                                snackbarMessage = "Детский счёт успешно открыт."
                                showSnackbar = true
                            }
                        )
                        
                    } label: {
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
                                    Text("Дети")
                                        .fontWeight(.bold)
                                    Text("\(members) участников")
                                }.foregroundColor(.primary)
                            }
                        }// members
                        .padding(.vertical)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.paymeC.opacity(0.8))
                        .clipShape(.rect(cornerRadius: 12))
                        
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
                                                        name: card.name,
                                                        ownerName: card.name,
                                                        sum: card.balance,
                                                        cardNumber: card.number,
                                                        type: .uzcard,
                                                        expirationDate: "11/27",
                                                        isFamilyCard: true, id: card.id, limit: card.limit))
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
                                                        type: .uzcard,
                                                        expirationDate: "11/27",
                                                        isFamilyCard: true, id: card.id,
                                                        limit: card.limit
                                                    ))
                                    .environmentObject(viewModel)
                                }
                            }
                            
                        }
                    }
                }
                
                .padding(12)
                .background(.backgroundC)
                
                .sheet(isPresented: $showAddFamilyMemberSheet) {
                    AddFamilyMember(viewModel: viewModel, showSnackbar: $showSnackbar, snackbarMessage: $snackbarMessage)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.hidden)
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
            
            
        }//Zstack
        .onAppear{
            viewModel.refreshData()
        }
        .refreshable{
            viewModel.refreshData()
        }
        .navigationTitle("Payme Kids")
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
    }
}

#Preview {
    FamilyView()
        .environmentObject(GlobalViewModel())
        .environmentObject(FamilyViewModel())
}
