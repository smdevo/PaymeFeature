//
//  BlockCardView.swift
//  PaymeFeature
//
//  Created by Umidjon on 22/04/25.
//

import SwiftUI

struct BlockCardView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    let completion: () -> ()

    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                Spacer()

                Image("lockIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)

                Text("Вы уверены, что хотите заблокировать карту?")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                Spacer()
                Text("ВНИМАНИЕ: Разблокировать карту можно только в банке при личном присутствии и удостоверении личности.")
                    .font(.footnote)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)

               

                Button(action: {
                    completion()
                }) {
                    Text("Заблокировать")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .navigationTitle("Блокировка карты")
            .navigationBarTitleDisplayMode(.inline)
           
            .background(
                Color(UIColor.systemBackground)
                    .edgesIgnoringSafeArea(.all)
            )
            .navigationBarBackButtonHidden()
        }
    }
}


#Preview {
    BlockCardView(completion: {})
}
