//
//  CardsView.swift
//  PaymeFeature
//
//  Created by Samandar on 08/04/25.
//

import SwiftUI


struct CardsView: View {
    
   // @StateObject var vm = CardsViewModel()
    
    @EnvironmentObject var vm: CardsViewModel
    
    @State var controllerTab: Int = 0
    
    @State private var showAddCardSheet: Bool = false
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    HeadLineView(title: "Barcha kartalar",
                                 isOn: controllerTab == 0
                    )
                    .onTapGesture {
                        controllerTab = 0
                    }
                    HeadLineView(title: "Uzcard", isOn: controllerTab == 1)
                        .onTapGesture {
                            controllerTab = 1
                        }
                    HeadLineView(title: "Humo", isOn: controllerTab == 2)
                        .onTapGesture {
                            controllerTab = 2
                        }
                    HeadLineView(title: "Family", isOn: controllerTab == 3)
                        .onTapGesture {
                            controllerTab = 3
                        }
                }
            }.scrollDisabled(true)
            
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
            plusButton
        }//overlay
        .padding(5)
    }//
}

#Preview {
    CardsView()
}

extension CardsView {
    
    private var plusButton: some View {
        
       
        Button {
            showAddCardSheet.toggle()
        } label: {
            Circle()
                .fill(.paymeC)
                .frame(width: 80)
                .overlay {
                    Image(systemName: "plus")
                        .resizable()
                        .padding(22)
                        .foregroundStyle(.white)
                }
        }.sheet(isPresented: $showAddCardSheet) {
            AddCardView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.hidden)
        }
    }
}



