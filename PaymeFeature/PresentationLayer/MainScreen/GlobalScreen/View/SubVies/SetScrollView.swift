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
    
    var body: some View {
        if evm.currentUser?.role ?? true {
            NavigationLink(destination: FamilyView()
                .environmentObject(evm)
                .environmentObject(viewModel)
            ) {
                FamilyViewScene()
            }
            .buttonStyle(PlainButtonStyle())
        }
        
        else{
            Section {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        GenericItemView(
                            title: "Ucell\n+998 94 042 64 01",
                            imageName: "phone.fill",
                            color: .purple
                        )
                        Button(action: { }) {
                            GenericItemView(
                                title: "Добавить",
                                imageName: "plus.circle",
                                color: .blue
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 12)
                }
                .cornerRadius(12)
                .padding(.horizontal)
            }
            
        header: {
            HStack {
                Text("Сохраненные платежи")
                    .font(.headline)
                    .padding(.horizontal)
                Spacer()
                Button(action: {
                }) {
                    Text("Все")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
                .padding(.bottom, 12)
                .padding(.horizontal)
            }
        }
        }
        
        if let user = viewModel.currentUser, user.invitation, viewModel.currentUser?.role == false {
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
                }
                .padding()
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
      
       // }
  
        
       
            
           
        
    }
}

func logOut() {
    UserDefaults.standard.removeObject(forKey: "userId")
    UserDefaults.standard.removeObject(forKey: "userFamilyId")
    
    switchToLogin()
}

func switchToLogin() {
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       let window = windowScene.windows.first {
        let hostingController = UIHostingController(rootView: LoginView())
        window.rootViewController = hostingController
        window.makeKeyAndVisible()
    }
    
}//Class


#Preview {
    SetScrollView().environmentObject(GlobalViewModel())
}
