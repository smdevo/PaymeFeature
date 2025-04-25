//
//  ContentViewForMapView.swift
//  PaymeFeature
//
//  Created by Umidjon on 22/04/25.
//

import SwiftUI
import MapKit

struct LocationPickerScreen: View {
    
    var closure: () -> ()
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedCoordinate: CLLocationCoordinate2D? = nil
    @State private var showAlert = false
    @State private var radius: Double = 700
    @State private var circleCenter = CLLocationCoordinate2D(latitude: 41.3240, longitude: 69.2410)
    
    @StateObject private var nameManager = LocationNameManager()
    
    let role = UserDefaults.standard.bool(forKey: "role")
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ZStack(alignment: .bottom) {
                LocationMapView(
                    selectedCoordinate: $selectedCoordinate,
                    showAlert: $showAlert,
                    circleCenter: $circleCenter,
                    radius: radius
                )
                .edgesIgnoringSafeArea(.all)
                .onChange(of: selectedCoordinate) { oldCoord, newCoord in
                    if let coord = newCoord {
                        nameManager.getName(from: coord)
                    }
                }
                if role {
                    VStack(spacing: 12) {
                        Text("Радиус зоны: \(Int(radius)) м")
                            .padding(8)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(10)
                        
                        Slider(value: $radius, in: 100...2000, step: 50)
                            .padding(.horizontal)
                            .accentColor(.red)
                        
                        if let _ = selectedCoordinate {
                            Text("Вы выбрали: \(nameManager.placeName)")
                                .padding(8)
                                .background(Color.white.opacity(0.9))
                                .cornerRadius(10)
                        }
                        
                        Button("Сохранить") {
                            closure()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding(.bottom, 30)
                    
                }
            }
            
            
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .padding(12)
                    .background(Color.white.opacity(0.9))
                    .clipShape(Circle())
                    .shadow(radius: 3)
            }
            .padding()
        }
        .alert("Выберите точку внутри круга", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
}

//
//#Preview {
//    LocationPickerScreen()
//}
