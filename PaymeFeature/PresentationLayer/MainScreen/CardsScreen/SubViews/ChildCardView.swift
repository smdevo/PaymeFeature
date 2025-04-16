//
//  ChildCardView.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 16/04/25.
//

import SwiftUI


struct ChildCardView: View {
    
    @State private var showParentServiceSheet = false
    @State private var showChildServiceSheet = false
    
    @EnvironmentObject var vm: GlobalViewModel
    let bankCard: BankCard
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(bankCard.name)
                .font(.title)
                .foregroundColor(.white)
                .textWithBlackBorder()
            
            Spacer()
            
            Text("\(bankCard.sum) сум")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .textWithBlackBorder()
            
            HStack {
                Image("paymekids")
                       .resizable()
                       .scaledToFit()
                       .frame(height: 110)
                
                Spacer()
                
                Image("kids")
                       .resizable()
                       .scaledToFit()
                       .frame(height: 80)
            }
            
        }
        .padding()
        .background {
            Group {
                if  !bankCard.isFamilyCard, vm.currentUser?.role == true {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.indigo.opacity(0.6), .paymeC]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                } else {
                    Image("girlBackground")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                }
            }
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
            .clipped()
        }
        
        
        .foregroundStyle(.white)
        .cornerRadius(16)
        
        .sheet(isPresented: $showParentServiceSheet) {
            ServicesSheetViewForParent()
                .presentationDetents([.fraction(0.6)])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showChildServiceSheet) {
            ServicesSheetViewForChild()
                .presentationDetents([.fraction(0.6)])
                .presentationDragIndicator(.visible)
        }
        .onTapGesture {
            if bankCard.isFamilyCard {
                guard let cUser = vm.currentUser else { return }
                if cUser.role {
                    showParentServiceSheet.toggle()
                } else {
                    showChildServiceSheet.toggle()
                }
            }
        }
    }
}

extension View {
    func textWithBlackBorder() -> some View {
        self.shadow(color: .black, radius: 1, x: 1, y: 1)
    }
}

#Preview {
    let model: BankCard = .init(name: "Apple Inc.", ownerName: "Apple Inc.", sum: "100", cardNumber: "100", type: .humo, expirationDate: "sfds")
    ChildCardView(bankCard: model)
        .environmentObject(GlobalViewModel())
        .padding()
}
