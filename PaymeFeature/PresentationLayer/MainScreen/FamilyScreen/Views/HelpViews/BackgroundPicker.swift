//
//  BackgroundPicker.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 16/04/25.
//

import SwiftUI

struct BackgroundSelectionView: View {
    
    @EnvironmentObject var evm: GlobalViewModel
    
    let settedBacks = [ "default", "girlBackground", "boyBackground", "abstractBackground", "natureBackground"]
    
    @State var backGroundImage = "default"
    
    @Environment(\.dismiss) var dismiss
    
    
    
    let id: String
    let completion: () -> ()
   
    
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                ScrollView {
                    
                    cardForBackground
                        .padding(.bottom, 180)
                    
                    Spacer()
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            
                            ForEach(settedBacks, id: \.self) { name in
                                Image(name)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipped()
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                                    .onTapGesture {
                                        backGroundImage = name
                                    }
                            }
                        }
                    }//Hscroll
                
                    
                }//ScrollView
                
                VStack {
                    
                    Spacer()
                    
                    Button(action: {
                        evm.backgroundImange[id] = backGroundImage
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
            }//Zstack
            .padding()
            .navigationTitle("Выберите фон")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        evm.backgroundImange[id] = backGroundImage
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
            }
        }
    }//body
    
    
    private var cardForBackground: some View {
        
        
            
        VStack(alignment: .leading,spacing: 10) {
                
                
                HStack {
                    Image("humo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45,height: 15)
                    
                    Spacer()
                    
                    Image("paymekidsborder")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 130,height: 15)
                    
                }
                
                Spacer()
                
                Text("")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.7), radius: 1, x: 1, y: 1)
                
                Spacer()
                
                
                    Text("")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.7), radius: 1, x: 1, y: 1)
               
               
                
                Spacer()
                
                Text("bankCard.cardNumber")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .padding(20)
            .padding(.horizontal)
            
            
            .background(
               
                    Image(backGroundImage)
                        .resizable()
                        .scaledToFill()
   
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
            
        
        
    }
    
    
}

#Preview {
    BackgroundSelectionView(id: "", completion: {})
}


