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
    //                .toolbar { backButton }
                
                Button {
                    showAddCardSheet.toggle()
                } label: {
                    Circle()
                        .fill(.paymeC)
                        .frame(width: 60)
                        .overlay {
                            Image(systemName: "plus")
                                .resizable()
                            
                                .padding(16)
                                .foregroundStyle(.white)
                        }
                }
                .sheet(isPresented: $showAddCardSheet) {
                    AddCardView()
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.hidden)
                }
            }.background(.backgroundC)
        }
        
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
    
    // MARK: — Кнопка «назад»
//    private var backButton: some ToolbarContent {
//        ToolbarItem(placement: .navigationBarLeading) {
//            Button {
//                
//            } label: {
//                Image(systemName: "chevron.left")
//                    .foregroundColor(.primary)
//            }
//        }
//    }
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
    ApprovedMarketsView()
}
