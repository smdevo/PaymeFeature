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
    
    private let cardAspectRatio: CGFloat = 340 / 210
    
    private let horizontalPadding: CGFloat = 12
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            
            HStack {
                Image("humo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45,height: 15)
                
                Spacer()
                Image("paymekidsborder")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 130,height: 15)
                
                HStack {
                    
                    Text("TBC Bank")
                        .foregroundColor(.white)
                        .textWithBlackBorder()
                }
            }
            
            Spacer()
            
            Text(bankCard.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.7), radius: 1, x: 1, y: 1)
            
            Spacer()
            
            if let sumInt = Int(bankCard.sum) {
                Text("\(sumInt.formattedWithSeparator) сум")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.7), radius: 1, x: 1, y: 1)
            }
            else {
                Text("\(bankCard.sum) сум")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.7), radius: 1, x: 1, y: 1)
            }
            
            Spacer()
            
            if let limit = bankCard.limit {
                Text("Лимит: \(limit)")
                    .font(.subheadline)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 10)
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            Spacer()
            
            Text(bankCard.cardNumber)
                .font(.subheadline)
                .foregroundColor(.white)
                .background(.red)
        }
        
        .padding(20)
        .padding(.horizontal, horizontalPadding)
        
        .frame(
            height: (UIScreen.main.bounds.width - horizontalPadding * 2)
            / cardAspectRatio,
            alignment: .topLeading
        )
        .background(
            ZStack(alignment: .bottomTrailing) {
                Group {
                    if !bankCard.isFamilyCard, vm.currentUser?.role == true {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.indigo.opacity(0.6), .paymeC]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    } else {
                        Image(vm.backgroundImange[bankCard.id] ?? "default")
                            .resizable()
                            .scaledToFill()
                    }
                }
                Image("childrens")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .fontWeight(.bold)
                    .padding(20)
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
        .onTapGesture {
            guard let cUser = vm.currentUser else { return }
            if cUser.role {
                showParentServiceSheet.toggle()
            } else {
                showChildServiceSheet.toggle()
            }
        }
        .sheet(isPresented: $showParentServiceSheet) {
            ServicesSheetViewForParent(id: bankCard.id)
                .presentationDetents([.fraction(0.6)])
        }
        .sheet(isPresented: $showChildServiceSheet) {
            ServicesSheetViewForChild(id: bankCard.id)
                .presentationDetents([.fraction(0.6)])
        }
    }
}

extension View {
    func textWithBlackBorder() -> some View {
        self.shadow(color: .black, radius: 3, x: 3, y: 3)
    }
}

#Preview {
    let model: BankCard = .init(name: "Apple Inc.", ownerName: "David Lee", sum: "100 000", cardNumber: "100 000 000", type: .humo, expirationDate: "sfds", id: "s", limit: "100 000")
    ChildCardView(bankCard: model)
        .environmentObject(GlobalViewModel())
}
