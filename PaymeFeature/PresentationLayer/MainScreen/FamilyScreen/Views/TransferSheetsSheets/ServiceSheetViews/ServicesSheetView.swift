//
//  ServicesSheetView.swift
//  PaymeFeature
//
//  Created by Samandar on 11/04/25.
//

/*
 
 Family Card (Team Card) -
 It is not only family card it is the team card in which
 we can do team spending and everybody see it
 
 */

enum ServicesType: String {
    case transfertoChildCard = "Перевести деньги на детскую карту"
    case setDailySpending = "Установить дневной лимит расходов"
    case chooseLocatiion = "Выбрать местоположение"
    case block = "Заблокировать карту"
    case selectApprovedMArkets = "Выбрать одобренные магазины"
    case selectBackgroundImage = "Выбрать фоновое изображение"
    case fulfillTheTaskAndGetMoneyCh = "Выполняйте задания, чтобы получить награду"

    case checkApprovedMArkets = "Проверить одобренные магазины"
    case checkApprovedLocation = "Проверить одобренное местоположение"
    case fulfillTheTaskAndGetMoneyP = "Назначить задания для награды"

}

struct UserService: Identifiable {
    let id = UUID()
    let type: ServicesType
    let icon: String
}
import SwiftUI
import MapKit

struct ServicesSheetViewForParent: View {
    
    @EnvironmentObject var viewModel: FamilyViewModel
    @EnvironmentObject var vm: GlobalViewModel
    
    @State private var showTransactionSheet = false
    @State private var showLimitationSheet = false
    @State private var showBackgroundPicker = false
    @State private var showBlockCardSheet = false
    @State private var showApprovedMArkets = false
    @State private var showChoosenLocations = false
    @State private var showFullFillTaskAndGetMoneyScreen = false
    
    
    
    @Environment(\.dismiss) var dismiss
    
    let id: String
    
    init(id: String) {
        self.id = id
    }
    
    
    
    let services: [UserService] = [
        .init(type: .transfertoChildCard,    icon: "arrow.down.circle"),
        .init(type: .setDailySpending,        icon: "calendar.badge.clock"),
        .init(type: .chooseLocatiion,         icon: "mappin.and.ellipse"),
        .init(type: .selectApprovedMArkets,   icon: "list.bullet.indent"),
        .init(type: .fulfillTheTaskAndGetMoneyP, icon: "s.circle"),
        .init(type: .selectBackgroundImage,   icon: "plus"),
        .init(type: .block,                   icon: "lock.shield")
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                HStack {
                    Text("Сервисы детской карты")
                        .font(.title3)
                        .bold()
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                Divider()
                    .padding(.vertical, 10)
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(services) { service in
                            
                            Button(action: {
                                handleServiceTap(service.type)
                            }) {
                                HStack {
                                    Label(service.type.rawValue, systemImage: service.icon)
                                        .font(.body)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(16)
                                .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
                            }
                            .buttonStyle(.plain)
                            
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            
            .background(Color(.systemBackground))
            .cornerRadius(20)
            .edgesIgnoringSafeArea(.bottom)
            .fullScreenCover(isPresented: $showTransactionSheet) {
                TransactionSheet(id: id, completion: {
                    dismiss()
                })
            }
            .fullScreenCover(isPresented: $showLimitationSheet) {
                SettingLimitationSheet(id: id, completion: {
                    dismiss()
                })
            }
            .fullScreenCover(isPresented: $showBackgroundPicker) {
                BackgroundSelectionView(id: id) {
                    dismiss()
                }
            }
            .fullScreenCover(isPresented: $showBlockCardSheet) {
                BlockCardView(completion: {
                    dismiss()
                })
            }
            .fullScreenCover(isPresented: $showApprovedMArkets) {
                ApprovedMarketsView {
                    dismiss()
                }
            }
            .fullScreenCover(isPresented: $showChoosenLocations) {
                
                LocationPickerScreen(closure: {
                    dismiss()
                })
            }
            .fullScreenCover(isPresented: $showFullFillTaskAndGetMoneyScreen) {
                FulfillTheTaskAndGetTheMoneyScreen()
            }
            
        }
    }
        
        func handleServiceTap(_ service: ServicesType) {
            switch service {
            case .transfertoChildCard:
                showTransactionSheet.toggle()
            case .setDailySpending:
                showLimitationSheet.toggle()
            case .chooseLocatiion:
                showChoosenLocations.toggle()
            case .block:
                showBlockCardSheet.toggle()
            case .selectBackgroundImage:
                showBackgroundPicker.toggle()
            case .selectApprovedMArkets:
                showApprovedMArkets.toggle()
            case .fulfillTheTaskAndGetMoneyP:
                showFullFillTaskAndGetMoneyScreen.toggle()
            default:
                break
            }
            
            
        }
    
}

#Preview {
    ServicesSheetViewForParent(id: "1")
}


