//
//  BackgroundPicker.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 16/04/25.
//

import SwiftUI

struct BackgroundSelectionView: View {
    
    @EnvironmentObject var evm: GlobalViewModel
    
    let settedBacks = ["girlBackground", "boyBackground", "abstractBackground", "natureBackground"]
    
    @Environment(\.dismiss) var dismiss
    
    let id: String
    
    
    init(id: String) {
        self.id = id
    }
    
   

    var body: some View {
        NavigationView {
            LazyVGrid(
                columns: [GridItem(.flexible()),
                          GridItem(.flexible()),
                          GridItem(.flexible())],
                spacing: 20
            ) {
                
                ForEach(settedBacks, id: \.self) { name in
                    Image(name)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipped()
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .onTapGesture {
                            evm.backgroundImange[id] = name
                            dismiss()
                        }
                }
            
            }
            .padding()
            .navigationTitle("Выберите фон")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}



