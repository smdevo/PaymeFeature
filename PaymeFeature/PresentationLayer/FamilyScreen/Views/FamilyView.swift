
//
//  FamilyView.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

struct FamilyView: View {
    @ObservedObject var viewModel: FamilyViewModel = FamilyViewModel()
    
    @State private var showFamilyCardAddSheet: Bool = false
    @State private var showAddFamilyMemberSheet: Bool = false
    
    
    var familyCards: [BankCard] = [
        BankCard(
            name: "Personal Debit Card",
            ownerName: "Alice Johnson",
            sum: "2500",
            cardNumber: "1111 2222 3333 4444",
            type: .uzcard,
            expirationDate: "12/25",
            cardColor: Color.green,
            iconName: "creditcard.fill",
            isFamilyCard: false
        )
//        BankCard(
//            name: "Family Virtual Card",
//            ownerName: "Johnson Family",
//            sum: "5000",
//            cardNumber: "5555 4444 3333 2222",
//            type: .uzcard,
//            expirationDate: "11/26",
//            cardColor: Color.blue,
//            iconName: "house.fill",
//            isFamilyCard: true
//        ),
//        BankCard(
//            name: "Business Credit Card",
//            ownerName: "Alice Johnson",
//            sum: "10000",
//            cardNumber: "7777 8888 9999 0000",
//            type: .mastercard,
//            expirationDate: "10/27",
//            cardColor: Color.purple,
//            iconName: "briefcase.fill",
//            isFamilyCard: true
//        )
    ]
    
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
                
                
                if ((viewModel.currentUser?.invitation) != false) {
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
                            
                            if let famCard = viewModel.familyCard {
                                CardView(bankCard:
                                            BankCard(
                                                name: famCard.name,
                                                ownerName: famCard.name,
                                                sum: famCard.balance,
                                                cardNumber: famCard.number,
                                                type: .humo,
                                                expirationDate: "11/27",
                                                isFamilyCard: true))
                            }
                            
                            ForEach(familyCards) { card in
                                CardView(bankCard: card)
                            }
                        }
                        .padding()
                    }
                }
                
                Spacer()
                
                if let user = viewModel.currentUser,
                   user.role
                {
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
                    
            }//Vstack
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
                        }.sheet(isPresented: $showAddFamilyMemberSheet) {
                            AddFamilyMember()
                                .presentationDetents([.medium])
                                .presentationDragIndicator(.hidden)
                        }
                        //                    }
                    }
                }
                
            }//toolbar
        }
        
    }
}
