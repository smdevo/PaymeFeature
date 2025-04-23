import SwiftUI

struct CardView: View {
    @EnvironmentObject var vm: GlobalViewModel
    let bankCard: BankCard

    private let cardAspectRatio: CGFloat = 340 / 210
    private let horizontalPadding: CGFloat = 12

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

                    Text("TBC Bank")
                        .foregroundColor(.white)
                        .textWithBlackBorder()
                }

                Spacer()

                
                let rawSum = bankCard.sum.replacingOccurrences(of: " ", with: "")
                let sumValue = Int(rawSum) ?? 0
                let formattedSum = sumValue.formattedWithSeparator
                Text("\(formattedSum) сум")
                    .font(.title2)
                    .foregroundColor(.white)
                    .textWithBlackBorder()
                    .fontWeight(.bold)
                Text(bankCard.ownerName)
                    .foregroundColor(.white)
                    .textWithBlackBorder()
                    .font(.title2)
                Spacer()

                Text("Main")
                    .foregroundColor(.white)
                    .textWithBlackBorder()

                Spacer()

                HStack {
                    Text(bankCard.cardNumber)
                        .fontWeight(.bold)
                        .font(.title2)
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
        
        .frame(
            height: (UIScreen.main.bounds.width - horizontalPadding * 2) / cardAspectRatio
        )
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        .foregroundStyle(.white)
    }
}
//
//#Preview {
//    let model = BankCard(
//        name: "Apple Inc.",
//        ownerName: "David Lee",
//        sum: "100 000",
//        cardNumber: "1234 5678 9012 3456",
//        type: .humo,
//        expirationDate: "11/27",
//        iconName: "star.fill",
//        isFamilyCard: false,
//        id: "s",
//        limit: nil
//    )
//    CardView(bankCard: model)
//        .environmentObject(GlobalViewModel())
//        .padding()
//}
