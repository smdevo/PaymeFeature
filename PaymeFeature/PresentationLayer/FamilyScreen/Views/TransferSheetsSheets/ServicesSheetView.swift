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
    case transfertoFamilyCard = "Transfer the money into family Card"
    case transferFromFamilyCard = "Tranfer Money from Family Card"
    case setDailySpending = "Set Daily Spending"
    case chooseLocatiion = "Choose Location"
    case block = "Block Card"
    case selectApprovedMArkets = "Select approved markets"
}

struct UserService: Identifiable {
    let id = UUID()
    let type: ServicesType
    let icon: String
}

import SwiftUI

struct ServicesSheetViewForParent: View {

    @State private var showTransactionSheet = false
    
    @Environment(\.dismiss) var dismiss
    
    let services: [UserService] = [
        .init(type: .transfertoFamilyCard, icon: "arrow.down.circle"),
        .init(type: .setDailySpending, icon: "calendar.badge.clock"),
        .init(type: .chooseLocatiion, icon: "mappin.and.ellipse"),
        .init(type: .block, icon: "lock.shield"),
        .init(type: .selectApprovedMArkets, icon: "list.bullet.indent")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Header
            HStack {
                Text("Family Card Services")
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
            
            // Services List
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
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $showTransactionSheet) {
            TransactionSheet()
                .presentationDetents([.fraction(0.6)])
                .presentationDragIndicator(.visible)
        }
    }
    
    func handleServiceTap(_ service: ServicesType) {
        switch service {
        case .transfertoFamilyCard:
            showTransactionSheet.toggle()
        case .setDailySpending:
            print("→ Set Daily Spending tapped")
        case .chooseLocatiion:
            print("→ Choose Location tapped")
        case .selectApprovedMArkets:
            print("Approved markets tapped")
        case .block:
            print("→ Block Card tapped")
        default:
            break
        }
    }
}

#Preview {
    ServicesSheetViewForParent()
}
