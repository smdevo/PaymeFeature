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
        
        Text("")
        Text("")
        Text("")
        Text("")
        Text("")
        Text("")
        Text("")
        Text("")
        Text("")
        Text("")
        Text("")
        Text("")
        Text("")
        Text("")
        Text("")
      
       // }
  
        
       
            
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
