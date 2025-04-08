//
//  SwiftUIView.swift
//  PaymeFeature
//
//  Created by Umidjon on 02/04/25.
//

import SwiftUI

 

struct TransfersView: View {
    @State private var cardOrPhone: String = ""

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Pul o’tkazmasi")
                        .font(.title2)
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

                HStack {
                    Image(systemName: "creditcard")
                        .foregroundColor(.gray)
                    TextField("Karta yoki telefon raqami", text: $cardOrPhone)
                        .keyboardType(.numberPad)
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
                            Image(systemName: "phone")
                            Text("Telefon raqami bo`yicha")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }

                    NavigationLink(destination: SelfTransferScreen()) {
                        HStack {
                            Image(systemName: "creditcard")
                            Text("Mening kartamga o’tkazish")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }

                    NavigationLink(destination: GreetingScreen()) {
                        HStack {
                            Image(systemName: "gift")
                            Text("Tabriknoma qo'shish")
                            Spacer()
                            Image(systemName: "plus")
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                }

                Spacer()
            }
            .padding()
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
