//
//  FriendsView.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

struct FamilyView: View {
    @StateObject var viewModel: FamilyViewModel
    @State private var showSendMoneySheet: Bool = false
    @State private var selectedMember: User?
    @State private var sendAmount: String = ""
    
    @State private var showFamilyCardAddSheet: Bool = false
    
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
                                    .onTapGesture {
                                        if viewModel.currentUser.role == "parent" && member.role == "child" {
                                            selectedMember = member
                                            showSendMoneySheet = true
                                        }
                                    }
                                Text(member.name)
                                    .font(.caption)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                if viewModel.currentUser.role == "parent" {
                    Divider()
                    Text("История детей")
                        .font(.headline)
                        .padding(.top)
                    
                    if viewModel.childrenHistory.isEmpty {
                        Text("Нет истории")
                            .foregroundColor(.gray)
                    } else {
                        List(viewModel.childrenHistory) { item in
                            switch item {
                            case .transaction(let txn):
                                if let sender = viewModel.allUsers.first(where: { $0.id == txn.fromUserID }),
                                   let recipient = viewModel.allUsers.first(where: { $0.id == txn.toUserID }) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Отправитель: \(sender.name)")
                                            .font(.headline)
                                        Text("Получатель: \(recipient.name)")
                                            .font(.subheadline)
                                        Text("Сумма: \(txn.amount, specifier: "%.2f")")
                                        Text("Описание: \(txn.description)")
                                        Text("Дата: \(formattedDate(txn.date))")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.vertical, 4)
                                } else {
                                    Text("Данные транзакции недоступны")
                                }
                            case .subscription(let sub):
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Подписка: \(sub.name)")
                                        .font(.headline)
                                    Text("Цена: \(sub.price, specifier: "%.2f")")
                                    Text("Дата обновления: \(formattedDate(sub.renewalDate))")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Семья")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if viewModel.currentUser.role == "parent" {
                        Button(action: {
                            showFamilyCardAddSheet.toggle()
                        }) {
                            Image(systemName: "plus.circle")
                        }
                    }
                }
            }
            .sheet(isPresented: $showSendMoneySheet) {
                SendMoneySheet(selectedMember: $selectedMember,
                               sendAmount: $sendAmount,
                               onSend: {
                    if let member = selectedMember, let amount = Double(sendAmount) {
                        viewModel.sendMoney(to: member, amount: amount)
                    }
                    showSendMoneySheet = false
                    sendAmount = ""
                }, onCancel: {
                    showSendMoneySheet = false
                    sendAmount = ""
                })
            }
            .sheet(isPresented: $showFamilyCardAddSheet) {
                FamilyCardAddView()
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.hidden)
            }
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
    
    
    
    extension FamilyViewModel {
        func updateFriends() {
            if let currentUser = LoginManager.shared.loggedInUser {
                self.familyMembers = currentUser.friends ?? []
            }
        }
    }
    
    
    
    
    struct FamilyViewContainer: View {
        @ObservedObject var authManager = LoginManager.shared
        
        var body: some View {
            if let currentUser = authManager.loggedInUser {
                let familyVM = FamilyViewModel(currentUser: currentUser, allUsers: authManager.users)
                FamilyView(viewModel: familyVM)
            } else {
                Text("Пожалуйста, войдите, чтобы увидеть семью")
                    .foregroundColor(.gray)
            }
        }
    }
    
