//
//  ChildCardsView.swift
//  PaymeFeature
//
//  Created by Samandar on 23/04/25.
//

import SwiftUI

struct ChildCardsView: View {
    
    @EnvironmentObject var vm: GlobalViewModel
    
    @State var controllerTab: Int = 0
    
    @State private var showAddCardSheet: Bool = false
    
    @State private var tasks: [Task] = [
        Task(title: "Уборка комнаты", reward: 500),
        Task(title: "Выполнение домашнего задания", reward: 800, isCompleted: true),
        Task(title: "Складывание белья", reward: 400),
        Task(title: "Кормление питомца", reward: 300, isCompleted: true),
        Task(title: "Мойка посуды", reward: 600)
        
    ]
    
    let role = UserDefaults.standard.bool(forKey: "role")
    
    var body: some View {
        VStack {
            
            if vm.cards.isEmpty {
                ProgressView()
            }else {
                
                ScrollView {
                    
                    LazyVStack {
                        ForEach(vm.cards.filter { $0.isFamilyCard }) { card in
                            
                            ChildCardView(bankCard: card)
                            
                        }
                        
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            
                            Text("Spend money with QR Code")
                                .font(.headline)
                                .bold()
                            
                            Spacer()
                            
                            Image(systemName: "s.circle")
                                .resizable()
                                .scaledToFit()
                                .font(.subheadline)
                                .frame(height: 30)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                                .shadow(radius: 10)
                            
                        )
                        .padding(.horizontal, 5)
                        .tint(.quickPay)
                    }
                    
                    Text("Мои задания")
                        .padding()
                        .font(.headline)
                        .bold()
                        .frame(alignment: .leading)
                    
                    LazyVStack(spacing: 12) {
                        ForEach(tasks.indices, id: \.self) { index in
                            TaskCard(task: $tasks[index], role: role)
                        }
                    }
                    .padding()
                    
                    HStack(alignment: .center) {
                        
                        Spacer()
                        
                        Button {
                            logOut()
                            
                        } label: {
                            HStack(spacing: 0) {
                                Text("Logout")
                                Image(systemName: "chevron.right")
                            }
                            .foregroundStyle(.unselectedTabbarItem)
                        }
                    }
                    .padding()
                    
                }
                .scrollIndicators(.hidden)
                
            }
            
            Spacer()
            
        }
        
        .padding(12)
        .refreshable {
            vm.loadUserAndFamily()
        }
        .navigationTitle("Мои карты")
        //.background(.backgroundC)
        .onAppear {
            vm.loadUserAndFamily()
        }
    }
}


#Preview {
    ChildCardsView()
        .environmentObject(GlobalViewModel())
        .environmentObject(FamilyViewModel())
}
