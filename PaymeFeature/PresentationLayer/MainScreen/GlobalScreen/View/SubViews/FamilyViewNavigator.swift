//
//  FamilyView.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 12/04/25.
//

import SwiftUI


struct FamilyViewScene: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.theme.paymeC)
                .frame(height: 100)
                .padding(.horizontal, .spacing(.x2))
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Payme Kids")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.labelC)
                    Text("Безопасный контроль детских расходов\nФинансовая грамотность для самых маленьких")
                        .font(.caption)
                        .foregroundColor(.labelC)
                }
                .padding(.leading, .spacing(.x5))
                .padding(.vertical, .spacing(.x2))
                
                Spacer()
                
                Image(uiImage: UIImage(named: "family_illustration") ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding(.trailing, .spacing(.x4))
                    .colorMultiply(.labelC)
            }
        }
        .padding(.vertical, .spacing(.x1))
       
    }
}


#Preview {
    FamilyViewScene().environmentObject(GlobalViewModel())
}
