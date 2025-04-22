//
//  TransactionSuccessfullyView.swift
//  PaymeFeature
//
//  Created by Umidjon on 21/04/25.
//

import SwiftUI

struct PaymentSuccessView: View {
    
    
    let amount: String
    let completion: () -> ()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            
            Image("payme")
                .resizable()
                .frame(width: 70, height: 70)
                .padding(.top, 40)
            Spacer()
            
            
            Image("successicon")
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
                Button(action: {
                    completion()
                }) {
                    VStack(spacing: 20) {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                            .font(.headline)
                            .fontWeight(.semibold)
                            .frame(height: 25)
                        
                        Text("Return to app")
                            .font(.footnote)
                    }
                    .frame(width: 90)
                }
                
                Spacer()
                
                Button(action: {}) {
                    VStack(spacing: 20) {
                        Image(systemName: "doc.text")
                            .resizable()
                            .scaledToFit()
                            .font(.headline)
                            .fontWeight(.semibold)
                            .frame(height: 25)
                        
                        Text("Cheque")
                            .font(.footnote)
                    }
                    .frame(width: 90)
                }
                
                Spacer()
                
                Button(action: {}) {
                    VStack(spacing: 20) {
                        Image(systemName: "star")
                            .resizable()
                            .scaledToFit()
                            .font(.headline)
                            .fontWeight(.semibold)
                            .frame(height: 25)
                        Text("Save")
                            .font(.footnote)
                    }
                    .frame(width: 90)
                }
            }
            .foregroundStyle(.gray)
            .padding(.horizontal, 40)
            .padding(.bottom, 60)
        }
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden()
    }
}



#Preview {
    PaymentSuccessView(amount: "235 000 сум", completion: {})
}

