//
//  TransactionSuccessfullyView.swift
//  PaymeFeature
//
//  Created by Umidjon on 21/04/25.
//

import SwiftUI

struct PaymentSuccessView: View {
    let amount: String
    
    
    var body: some View {
        VStack(spacing: 20) {
            
            Image("payme")
                .resizable()
                .frame(width: 70, height: 70)
                .padding(.top, 40)
            Spacer()
            
            
            Image("successfullyCardIcon")
                .resizable()
                .frame(width: 140, height: 140)
                
            
            
            Text(amount)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
             
            
            Text("Успешно оплачено")
                .font(.title2)
                .fontWeight(.semibold)
            
            
            Text("В случае задержки получения товаров или услуг обратитесь в службу поддержки поставщика.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            
            Spacer()
            
            
            HStack {
                Button(action: {}) {
                    VStack {
                        Image(systemName: "arrow.left")
                        Text("Return to app")
                            .font(.footnote)
                    }
                }
                Spacer()
                Button(action: {}) {
                    VStack {
                        Image(systemName: "doc.text")
                        Text("Cheque")
                            .font(.footnote)
                    }
                }
                Spacer()
                Button(action: {}) {
                    VStack {
                        Image(systemName: "star")
                        Text("Save")
                            .font(.footnote)
                    }
                }
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 30)
        }
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.all)
    }
}



#Preview {
    PaymentSuccessView(amount: "235 000 сум")
}

