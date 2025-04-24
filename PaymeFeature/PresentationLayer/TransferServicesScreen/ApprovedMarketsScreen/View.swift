//
//  View.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 21/04/25.
//

import SwiftUI

struct MarketItem: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
}

struct ApprovedMarketsView: View {
    // MARK: — Данные
    
    @State private var showAddCardSheet: Bool = false
    
    let role = UserDefaults.standard.bool(forKey: "role")
    
    let completion: () -> ()
    
    private let items: [MarketItem] = [
        .init(title: "Safiа", imageName: "safia"),
        .init(title: "Korzinka", imageName: "korzinka"),
        .init(title: "Makro", imageName: "makro"),
        .init(title: "Ucell", imageName: "ucell"),
        .init(title: "Uztelecom", imageName: "uztelecom"),
        .init(title: "Uzum", imageName: "uzum"),
        .init(title: "Yandex GO", imageName: "yandex"),
        
        
            .init(title: "Korzinka", imageName: "korzinka"),
        .init(title: "Makro", imageName: "makro"),
        .init(title: "Ucell", imageName: "ucell"),
        .init(title: "Uztelecom", imageName: "uztelecom"),
        .init(title: "Uzum", imageName: "uzum"),
        .init(title: "Yandex GO", imageName: "yandex"),
    ]
    private let columns: [GridItem] = Array(
        repeating: .init(.flexible(), spacing: 16),
        count: 3
    )
    
    var body: some View {
        NavigationStack {
            
            VStack{
                content
                    .background(Color.backgroundC)
                    .navigationTitle("Доверенные продавцы")
                    .navigationBarTitleDisplayMode(.inline)
                
                Button(action: {
                    completion()
                }) {
                    Text("Вернуться в приложение")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.paymeC)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 40)
                }
                
                Spacer().frame(height: 30)
                
            }.background(.backgroundC)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        
                        if role {
                            
                            Button {
                                showAddCardSheet.toggle()
                            } label: {
                                Circle()
                                    .fill(.paymeC)
                                    .frame(height: 40)
                                    .overlay {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(10)
                                            .foregroundStyle(.white)
                                    }
                            }
                            .sheet(isPresented: $showAddCardSheet) {
                                AddCardView()
                                    .presentationDetents([.medium])
                                    .presentationDragIndicator(.hidden)
                            }
                            
                        }
                    }
                }
        }//
        
    }
    
    // MARK: — Основной скролл + грид
    private var content: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(items) { item in
                    MarketItemCell(item: item)
                }
            }
            .padding(16)
        }
    }
    
}

// MARK: — Вынесенная ячейка сетки
struct MarketItemCell: View {
    
    let item: MarketItem
    
    var body: some View {
        VStack(spacing: 8) {
            Image(item.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            
            Text(item.title)
                .foregroundColor(.black)
                .font(.footnote)
                .multilineTextAlignment(.center)
            
                .lineLimit(2)
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .aspectRatio(1, contentMode: .fit)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 3)
    }
    
}





#Preview {
    ApprovedMarketsView(completion: {})
}
