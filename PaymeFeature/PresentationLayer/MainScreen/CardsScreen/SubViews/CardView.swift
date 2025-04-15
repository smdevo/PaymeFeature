import SwiftUI


struct CardView: View {
    
    @State private var showParentServiceSheet = false
    @State private var showChildServiceSheet = false
    
    @EnvironmentObject var vm: GlobalViewModel
    let bankCard: BankCard
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            if  !bankCard.isFamilyCard, vm.currentUser?.role == true {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.indigo.opacity(0.6), .paymeC]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
            } else {
                Image("детский_фон")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(bankCard.type.rawValue)
                        .font(.headline)
                        .foregroundColor(.white)
                        .textWithBlackBorder()
                    
                    Spacer()
                    
                    HStack {
                        if bankCard.isFamilyCard {
                            Image(systemName: "figure.and.child.holdinghands")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 24)
                                .foregroundColor(.white)
                        }
                        Text("TBC Bank")
                            .foregroundColor(.white)
                            .textWithBlackBorder()
                    }
                }
                
                Spacer()
                
                Text("\(bankCard.sum) сум")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .textWithBlackBorder()
                
                bankCard.isFamilyCard ?
                    Text("Детская карта")
                        .foregroundColor(.white)
                        .textWithBlackBorder()
                : Text(bankCard.ownerName)
                    .foregroundColor(.white)
                    .textWithBlackBorder()
                
                Spacer()
                
                Text("main or dailySpendingForParent")
                    .foregroundColor(.white)
                    .textWithBlackBorder()
                
                Spacer()
                
                HStack {
                    Text(bankCard.cardNumber)
                        .fontWeight(.bold)
                        .font(.title3)
                        .textWithBlackBorder()
                    Spacer()
                    Text(bankCard.expirationDate)
                        .textWithBlackBorder()
                }
                .foregroundColor(.white)
                .font(.subheadline)
            }
            .padding()
        }
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        .foregroundStyle(.white)
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
