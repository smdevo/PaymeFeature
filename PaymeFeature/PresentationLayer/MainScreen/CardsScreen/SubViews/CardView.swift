import SwiftUI


struct CardView: View {
    
    @EnvironmentObject var vm: GlobalViewModel
    

    
    let bankCard: BankCard
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
           
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.indigo, .paymeC]),
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
                        .textWithBlackBorder()
                    
                    Spacer()
                    
                    HStack {
                        
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
                
                Text(bankCard.ownerName)
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
       
    }
}
//
//extension View {
//    func textWithBlackBorder() -> some View {
//        self.shadow(color: .black, radius: 1, x: 1, y: 1)
//    }
//}

