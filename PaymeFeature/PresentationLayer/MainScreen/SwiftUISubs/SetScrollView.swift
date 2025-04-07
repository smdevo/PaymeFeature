//
//  SetScrollView.swift
//  PaymeFeature
//
//  Created by Samandar on 04/04/25.
//

import SwiftUI
import UIKit


class SetScrollViewModel: ObservableObject {
    
    @Published var currencies: [Currency] = []

    private let server = CurrencyNetworkingService()
   
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        
        server.fetchSelectedCurrencies(codes: ["USD","EUR","RUB","GBP"]) { currencies in
            guard let currencies else
            {
                return
            }
            self.currencies = currencies
        }
        
    }
    
}


struct SetScrollView: View {
    
    @StateObject var vm =  SetScrollViewModel()

    
    
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
                                    .shadow(radius: 10)
                            }
                            .padding()
                            
                        }//FOREACH
                        
                    }//else
                }
            }//ScrollView
            .scrollIndicators(.hidden)
            
            HStack {
                
                Spacer()
                
                Button {
                    
                    
                } label: {
                    
                    HStack(spacing: 0) {
                        Text("Hammasi")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(.unselectedTabbarItem)
                }
                
            }
            .padding(.horizontal)
        }//Vstack
    }//body
}//Class

#Preview {
            SetScrollView()
}
