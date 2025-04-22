//
//  CardLimitView.swift
//  PaymeFeature
//
//  Created by Umidjon on 21/04/25.
//


import SwiftUI

struct CardLimitSetView: View {
    
    let limitAmount: String
    
    let completion: () -> ()
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            
            Image("successicon")
                .resizable()
                .frame(width: 180, height: 180)
                .foregroundColor(.green)
                .padding(.bottom, -20)
            
            
            Text("Лимит успешно установлен")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            
            Text("Новый лимит: \(limitAmount) сум")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            
            Text("Теперь ваш ребёнок не сможет потратить больше заданной суммы с этой карты.\nВы всегда можете изменить лимит в настройках.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            
            Spacer()
            
            
            Button(action: {
                completion()
            }) {
                Text("Вернуться в приложение")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.paymeC)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 40)
            }
            
            Spacer().frame(height: 30)
        }
        .padding()
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden()
    }
}


#Preview {
    CardLimitSetView(limitAmount: "100 000", completion: {})
}
