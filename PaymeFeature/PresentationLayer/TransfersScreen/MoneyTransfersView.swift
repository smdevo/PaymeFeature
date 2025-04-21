//
//  MoneyTransfersView.swift
//  PaymeFeature
//
//  Created by Umidjon Fayzimatov on 21/04/25.
//


import SwiftUI

struct MoneyTransferView: View {
    var cardNumber: String
    
    @State private var amount: String = ""
    @State private var note: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack {
                    Image(systemName: "creditcard")
                        .foregroundColor(.orange)
                    VStack(alignment: .leading) {
                        Text(cardNumber)
                            .font(.body)
                        Text("Fayzimatov U.")
                            .font(.subheadline)
                            .foregroundColor(.green)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)

                VStack(alignment: .leading, spacing: 10) {
                    Text("O‘tkazma summasi")
                        .font(.headline)

                    TextField("O‘tkazma summasi", text: $amount)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Izoh (Majburiy emas)")
                        .font(.headline)
                    TextField("Izoh", text: $note)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Tez summalar")
                        .font(.headline)
                    HStack {
                        ForEach(["100000", "400000", "500000", "600000", "800000"], id: \.self) { value in
                            Button(action: {
                                amount = value
                            }) {
                                Text(value)
                                    .padding(10)
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(10)
                            }
                        }
                    }
                }

                NavigationLink(destination: Text("Tabriknoma tanlash")) {
                    HStack {
                        Image(systemName: "gift.fill")
                            .foregroundColor(.purple)
                        Text("Tabriknoma qo‘shish")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }

                Spacer()

                Button(action: {
                }) {
                    Text("Oldinga")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.bottom)
            }
            .padding()
            .navigationTitle("Pul o‘tkazmasi")
        }
    }
}

#Preview {
    MoneyTransferView(cardNumber: "5614 68•••• •••• 1175")
}

