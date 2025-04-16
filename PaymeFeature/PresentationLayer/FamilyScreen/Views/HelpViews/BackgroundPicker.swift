//
//  BackgroundPicker.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 16/04/25.
//

import SwiftUI

struct BackgroundSelectionView: View {
    @Environment(\.dismiss) var dismiss
    let backgroundNames: [String] = ["girlBackground", "boyBackground", "abstractBackground", "natureBackground"]
    var onSelect: (String) -> Void

    var body: some View {
        NavigationView {
            LazyVGrid(
                columns: [GridItem(.flexible()),
                          GridItem(.flexible()),
                          GridItem(.flexible())],
                spacing: 20
            ) {
                ForEach(backgroundNames, id: \.self) { name in
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
                            onSelect(name)
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



