import SwiftUI

struct FoodOrderView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("FoodOrderView")
                .font(.largeTitle)
                .foregroundColor(.gray)
            Spacer()
        }
        .navigationTitle("Заказ еды")
    }
}

