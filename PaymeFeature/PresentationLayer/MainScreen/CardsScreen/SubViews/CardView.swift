
import SwiftUI

struct CardView: View {
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
            .padding()
        }
        .frame(height: 160)
    }
}
