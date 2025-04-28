//
//  CardsView.swift
//  PaymeFeature
//
//  Created by Samandar on 08/04/25.
//

import SwiftUI


struct CardsView: View {
    
    @EnvironmentObject var vm: GlobalViewModel
    
    @State var controllerTab: Int = 0
    
    @State private var showAddCardSheet: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<4) { index in
                    let titles = ["All", "Uzcard", "Humo", "Family"]
                    HeadLineView(title: titles[index], isOn: controllerTab == index)
                        .onTapGesture {
                            controllerTab = index
                        }
                        .frame(maxWidth: .infinity)
                    
                }
                
            }
            .padding(.horizontal)
            
            if vm.cards.isEmpty {
                ProgressView()
            }else {
                TabView(selection: $controllerTab) {
                    CardsTableView(cards: vm.cards)
                        .tag(0)
                    
                    CardsTableView(cards: vm.cards.filter { $0.type == .uzcard })
                        .tag(1)
                    
                    CardsTableView(cards: vm.cards.filter { $0.type == .humo })
                        .tag(2)
                    
                    CardsTableView(cards: vm.cards.filter { $0.isFamilyCard })
                        .tag(3)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut(duration: 0.3), value: controllerTab)
                
            }
            
            Spacer()
            
        }
        .overlay(alignment: .bottom) {
            if ((vm.currentUser?.role) != false) {
                plusButton
            }
        }
        .padding(12)
        .refreshable {
            vm.loadUserAndFamily()
        }
        .navigationTitle("Мои карты")
        .background(.backgroundC)
        .onAppear {
            vm.loadUserAndFamily()
        }
    }
}

extension CardsView {
    
    private var plusButton: some View {
       
        Button {
            showAddCardSheet.toggle()
        } label: {
            Circle()
                .fill(.paymeC)
                .frame(width: 60)
                .overlay {
                    Image(systemName: "plus")
                        .resizable()
                        .padding(16)
                        .foregroundStyle(.white)
                }
        }.sheet(isPresented: $showAddCardSheet) {
            AddCardView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.hidden)
        }
    }
}



