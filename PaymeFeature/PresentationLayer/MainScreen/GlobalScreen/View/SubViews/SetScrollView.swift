//
//  SetScrollView.swift
//  PaymeFeature
//
//  Created by Samandar on 04/04/25.
//

import SwiftUI
import UIKit


struct SetScrollView: View {
    
    @EnvironmentObject var evm: GlobalViewModel
    @StateObject var viewModel: FamilyViewModel = FamilyViewModel()
    
    @State var invitationCode = ""
    @State var showInvitationAlert = false
    
    let role = UserDefaults.standard.bool(forKey: "role")
    
    var body: some View {
        
        if role {
            
            NavigationLink(destination: FamilyView()
                .environmentObject(evm)
                .environmentObject(viewModel)
            ) {
                FamilyViewScene()
            }
            .buttonStyle(PlainButtonStyle())
        }
        
        if let user = viewModel.currentUser, user.invitation, user.role == false {
            Button(action: {
                showInvitationAlert = true
            }) {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.paymeC)
                    Text("Подтвердите приглашение в семью")
                        .font(.subheadline)
                        .foregroundColor(.paymeC)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding()
            }
            .alert("Подтверждение приглашения", isPresented: $showInvitationAlert) {
                TextField("Введите код", text: $invitationCode)
                Button("Confirm") {
                    viewModel.confirmInvitation(enteredCode: invitationCode) { success in
                        if success {
                            print("Success")
                        } else {
                            print("Failure")
                        }
                    }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Введите код подтверждения, который вы получили")
            }
            
        }
        
        //MARK: pay
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    
                    GenericItemView(title: "Популярное",
                                     imageName: "star.fill",
                                     color: .yellow)
                    GenericItemView(title: "Мобильные\nоператоры",
                                     imageName: "antenna.radiowaves.left.and.right",
                                     color: .blue)
                    GenericItemView(title: "Интернет-\nпровайдеры",
                                     imageName: "wifi",
                                     color: .green)
                    GenericItemView(title: "Интернет-\nпровайдеры",
                                     imageName: "wifi",
                                     color: .green)
                    
                }
            }
            .cornerRadius(12)
            .padding(.horizontal)
        } header: {
            HStack {
                Text("Оплата услуг")
                    .font(.headline)
                    .padding(.horizontal)
                Spacer()
                Button(action: {
                }) {
                    Text("Все")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
                .padding(.horizontal)
            }
        }
        
        HStack(alignment: .center) {
            
            Spacer()
            
            Button {
                logOut()
                
            } label: {
                HStack(spacing: 0) {
                    Text("Logout")
                    Image(systemName: "chevron.right")
                }
                .foregroundStyle(.unselectedTabbarItem)
            }
        }
        .padding()
      
    }
}


#Preview {
    SetScrollView().environmentObject(GlobalViewModel())
}
