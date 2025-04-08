//
//  SwiftUIView.swift
//  PaymeFeature
//
//  Created by Umidjon on 02/04/25.
//

import SwiftUI

 
struct TransfersView: View {
    @State private var cardOrPhone: String = ""

    func formatCardNumber(_ number: String) -> String {
        let cleanNumber = number.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        let truncatedNumber = String(cleanNumber.prefix(16))
        
        var formattedNumber = ""
        
        for (index, char) in truncatedNumber.enumerated() {
            if index != 0 && index % 4 == 0 {
                formattedNumber.append(" ")
            }
            formattedNumber.append(char)
        }
        
        return formattedNumber
    }

    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Spacer()
                    Text("Pul o’tkazmasi")
                        .font(.title3)
                        .bold()
                    Spacer()
                    NavigationLink(destination: InfoScreen()) {
                        Image(systemName: "info.circle")
                            .font(.title2)
                    }
                }
                .padding(.top)
                
                Text("Kimga:")
                    .font(.headline)
                    .padding(.top, 30)
                Text("Karta yoki telefon raqami")
                    .foregroundStyle(.gray)
                    .font(.system(size:14))
                    .padding(.bottom, -20)
                HStack {
                    Image(systemName: "creditcard")
                        .foregroundColor(.gray)
                    TextField("Karta yoki telefon raqami", text: $cardOrPhone)
                        .keyboardType(.numberPad)
                        .onChange(of: cardOrPhone) { newValue in
                            cardOrPhone = formatCardNumber(newValue)
                        }
                        .font(.system(size: 14))
//                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    Button(action: {
                    }) {
                        Image(systemName: "qrcode.viewfinder")
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)

                Button(action: {
                }) {
                    HStack {
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                        Text("Qo’shish")
                            .foregroundColor(.blue)
                    }
                }

                Text("Barchasi")
                    .foregroundColor(.blue)
                    .onTapGesture {
                    }

                VStack(spacing: 12) {
                    NavigationLink(destination: PhoneTransferScreen()) {
                        HStack {
                            Image(systemName: "phone.fill")
                                .foregroundColor(.paymeC)
                            Text("Telefon raqami bo`yicha")
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }

                    NavigationLink(destination: SelfTransferScreen()) {
                        HStack {
                            Image(systemName: "creditcard")
                                .foregroundColor(.paymeC)
                            Text("Mening kartamga o’tkazish")
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }

                    NavigationLink(destination: GreetingScreen()) {
                        HStack {
                            Image(systemName: "gift")
                                .foregroundColor(.paymeC)
                            Text("Tabriknoma qo'shish")
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "plus")
                                .foregroundStyle(.gray)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                }
                

                Spacer()
            }
            .padding([.bottom, .leading, .trailing],15)
        }
    }
}

struct PhoneTransferScreen: View {
    var body: some View {
        Text("Telefon raqam bo'yicha o'tkazma")
            .navigationTitle("Telefon bo‘yicha")
    }
}

struct SelfTransferScreen: View {
    var body: some View {
        Text("Mening kartamga o'tkazish")
            .navigationTitle("O'z kartamga")
    }
}

struct GreetingScreen: View {
    var body: some View {
        Text("Tabriknoma qo'shish sahifasi")
            .navigationTitle("Tabriknoma")
    }
}

struct InfoScreen: View {
    var body: some View {
        Text("Bu sahifa orqali pul o'tkazishingiz mumkin.")
            .padding()
            .navigationTitle("Ma'lumot")
    }
}



#Preview {
    TransfersView()
}
