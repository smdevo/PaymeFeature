import SwiftUI

struct ServiceView: View {
    @StateObject private var viewModel = ServicesViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Сервисы")
                    .font(.title)
                    .bold()
                    .padding(.top, 20)
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(viewModel.services) { service in
                            if service.name == "Заказ еды" {
                                NavigationLink(destination: FoodOrderView()) {
                                    ServiceButton(service: service)
                                }
                            } else {
                                Button(action: {}) {
                                    ServiceButton(service: service)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}



