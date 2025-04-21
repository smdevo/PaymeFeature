//
//  AuthScreen.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

struct ServiceView: View {
    @StateObject private var viewModel = ServicesViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Сервисы")
                    .font(.title)
                    .bold()
                    .padding(.top, 20)
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(viewModel.services) { service in
                            if service.name == "Моя семья" {
                                NavigationLink(destination: FamilyView()) {
                                    ServiceButton(service: service)
                                }
                            } else {
                                Button(action: {}) {
                                    ServiceButton(service: service)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ServiceView()
}


