
import SwiftUI

struct CardView: View {
    
    @State private var showTransactionSheet = false
    
    let bankCard: BankCard
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .blue.opacity(0.6)]),
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
            }
            
        }
        .padding()
        .background(bankCard.cardColor)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        .foregroundStyle(.white)
        .sheet(isPresented: $showTransactionSheet, content: {
            TransactionSheet()
                .presentationDetents([.fraction(0.6)])
                .presentationDragIndicator(.visible)
        })
        .onTapGesture {
            if !bankCard.isFamilyCard {
                showTransactionSheet.toggle()
            }
        }
        
    }
}

#Preview {
    VStack {
        CardView(bankCard: BankCard(name: "Aloqabank", ownerName: "Samandar Toshpulatov", sum: "60400", cardNumber: "7789098756432118", type: .uzcard,expirationDate: "11/25"))
            .padding()
        }
        .frame(height: 160)
    }
}
