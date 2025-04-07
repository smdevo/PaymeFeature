//
//  SetScrollView.swift
//  PaymeFeature
//
//  Created by Samandar on 04/04/25.
//

import SwiftUI


class SetScrollViewModel: ObservableObject {
    
    @Published var currencies: [Currency] = [
        
        Currency(id: 10, code: "840", currency: "USD", nameRU: "", nameUZ: "", nameUZC: "", nameEN: "", nominal: "13000", rate: "13000", diff: "12", date: "as"),
        Currency(id: 10, code: "840", currency: "USD", nameRU: "", nameUZ: "", nameUZC: "", nameEN: "", nominal: "13000", rate: "13000", diff: "12", date: "as"),
        Currency(id: 10, code: "840", currency: "USD", nameRU: "", nameUZ: "", nameUZC: "", nameEN: "", nominal: "13000", rate: "13000", diff: "-12", date: "as")
        
    ]
   
    
    
}


struct SetScrollView: View {
    
    @StateObject var vm = SetScrollViewModel()
    
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                
                ForEach(vm.currencies) { currency in
                    
                    HStack {
                        
                        Text(currency.flag)
                            .padding()
                        
                        
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
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(radius: 10)
                    }
                    .padding()
                    
                }
            }
        }
        .scrollIndicators(.hidden)
        
    }
}

#Preview {
    SetScrollView()
}
