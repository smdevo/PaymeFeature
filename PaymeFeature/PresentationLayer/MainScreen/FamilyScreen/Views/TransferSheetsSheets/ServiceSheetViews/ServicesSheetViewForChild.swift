//
//  Untitled.swift
//  PaymeFeature
//
//  Created by Samandar on 11/04/25.
//


import SwiftUI

struct ServicesSheetViewForChild: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showApprovedLocation = false
    @State private var showSelectingBackgroundView = false
    @State private var showApprovedMArkets = false
    @State private var showBlockView = false
    @State private var showTasksView = false

    let id: String
    
    init(id: String) {
        self.id = id
    }
    
    struct Service: Identifiable {
        let id = UUID()
        let title: String
        let icon: String
    }
    
    let services: [UserService] = [
        .init(type: .checkApprovedMArkets, icon: "list.bullet.indent"),
        .init(type: .checkApprovedLocation, icon: "mappin.and.ellipse"),
        .init(type: .fulfillTheTaskAndGetMoneyCh, icon: "s.circle"),
        .init(type: .selectBackgroundImage,   icon: "plus"),
        .init(type: .block,                   icon: "lock.shield")
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
//        .fullScreenCover(isPresented: $showApprovedLocation) {
//
//        }
        .fullScreenCover(isPresented: $showSelectingBackgroundView) {
            BackgroundSelectionView(id: id) {
                dismiss()
            }
        }
        .fullScreenCover(isPresented: $showBlockView) {
            BlockCardView {
                dismiss()
            }
        }
        .fullScreenCover(isPresented: $showApprovedMArkets) {
            ApprovedMarketsView {
                dismiss()
            }
        }
        .fullScreenCover(isPresented: $showTasksView) {
            FulfillTheTaskAndGetTheMoneyScreen()
        }
        
        
        
    }
    
    func handleServiceTap(_ service: ServicesType) {
        switch service {
        case .checkApprovedMArkets:
            showApprovedMArkets.toggle()
        case .checkApprovedLocation:
            showApprovedLocation.toggle()
        case .fulfillTheTaskAndGetMoneyCh:
            showTasksView.toggle()
        case .selectBackgroundImage:
            showSelectingBackgroundView.toggle()
        case .block:
            showBlockView.toggle()
        default:
            break
        }
    }
}

#Preview {
    ServicesSheetViewForChild(id: "1")
}
