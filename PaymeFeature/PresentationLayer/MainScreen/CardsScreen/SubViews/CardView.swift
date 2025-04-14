
import SwiftUI

struct CardView: View {
    
    @State private var showParentServiceSheet = false
    @State private var showChildServiceSheet = false
    
    @EnvironmentObject var vm: GlobalViewModel

    let bankCard: BankCard
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.black.opacity(0.7), .paymeC]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(bankCard.type.rawValue)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    if bankCard.isFamilyCard {
                        Image(systemName: "figure.and.child.holdinghands")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 24)
                            .foregroundColor(.white)
                    }
                }
                
                Text("\(bankCard.sum) сум")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(bankCard.ownerName)
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack {
                    Text(bankCard.cardNumber)
                    Spacer()
                    Text(bankCard.expirationDate)
                }
                .foregroundColor(.white)
                .font(.subheadline)
            }.padding()
            
        }
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        .foregroundStyle(.white)
        .sheet(isPresented: $showParentServiceSheet, content: {
            ServicesSheetViewForParent()
                .presentationDetents([.fraction(0.6)])
                .presentationDragIndicator(.visible)
        })
        .sheet(isPresented: $showChildServiceSheet, content: {
            ServicesSheetViewForChild()
                .presentationDetents([.fraction(0.6)])
                .presentationDragIndicator(.visible)
        })
        .onTapGesture {
            if bankCard.isFamilyCard {
                guard let cUser = vm.currentUser else { return }
                
                if cUser.role {
                    showParentServiceSheet.toggle()
                }else {
                    showChildServiceSheet.toggle()
                }
            }
        }
        
    }
}

