//
//  SetScrollView.swift
//  PaymeFeature
//
//  Created by Samandar on 04/04/25.
//

import SwiftUI
import UIKit


struct SetScrollView: View {
    
    @StateObject var vm =  SetScrollViewModel()
    
    @EnvironmentObject var evm: GlobalViewModel
    
    
    var body: some View {
        
        VStack {
            
            ScrollView(.horizontal) {
                HStack {
                    
                    if vm.currencies.isEmpty {
                        HStack {
                            ProgressView()
                        }
                    }else {
                        
                        ForEach(vm.currencies) { currency in
                            HStack {
                                ZStack {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 50)
                                    
                                    Text(currency.flag)
                                        .padding()
                                }
                                VStack(alignment: .leading){
                                    
                                    Text("Pul Birligi")
                                    
                                    Text(currency.code)
                                }
                                
                                VStack(alignment: .leading){
                                    
                                    Text("Qiymati")
                                    
                                    Text(currency.rate)
                                }
                                
                                VStack{
                                    Text("O'zgarish")
                                    Text(currency.diff)
                                }
                            }
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.theme.backgroundColor)
                                    .shadow(radius: 5)
                            }
                            .padding(.spacing(.x2))
                            
                            
                        }
                        
                    }
                }.padding(.top, .spacing(.x7))
            }
            .scrollIndicators(.hidden)
            
            HStack {
                
                Spacer()
                
                Button {
                    logOut()
                    
                } label: {
                    HStack(spacing: 0) {
                        Text("all currencies")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(.unselectedTabbarItem)
                }
            }
            .padding(.horizontal)
        }
        
        NavigationLink(destination: FamilyView().environmentObject(evm)) {
            FamilyViewScene()
        }
        .buttonStyle(PlainButtonStyle())
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
