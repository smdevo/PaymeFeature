//
//  Untitled.swift
//  PaymeFeature
//
//  Created by Samandar on 11/04/25.
//


import SwiftUI

struct ServicesSheetViewForChild: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var showTransactionSheet = false
    
    struct Service: Identifiable {
        let id = UUID()
        let title: String
        let icon: String
    }
    
    let services: [UserService] = [
        .init(type: .transferFromFamilyCard, icon: "arrow.up.circle")
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
        case .transferFromFamilyCard:
            showTransactionSheet.toggle()
        case .selectBackgroundImage:
            print("selectBackgroundImage")
        default:
            break
        }
    }
}

//#Preview {
//    ServicesSheetViewForParent()
//}
