//
//  SwiftUIView.swift
//  PaymeFeature
//
//  Created by Umidjon on 02/04/25.
//


import SwiftUI
struct TransfersView: View {
    @State private var cardOrPhone: String = ""
    @State private var isCardValid = false
    
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
            VStack(alignment: .leading, spacing: 10) {
                
                HStack {
                    Spacer()
                    Text("Pul o’tkazmasi")
                        .font(.title3)
                        .bold()
                    Spacer()
                }
                .padding(.top)
                
                Text("Kimga:")
                    .font(.headline)
                
                Text("Karta yoki telefon raqami")
                    .foregroundStyle(.gray)
                    .font(.system(size: 14))

                HStack {
                    Image(systemName: "creditcard")
                        .foregroundColor(.gray)
                    

                    
                    TextField("Karta yoki telefon raqami", text: $cardOrPhone)
                        .keyboardType(.numberPad)
                        .font(.system(size: 14))
                        .onChange(of: cardOrPhone) { newValue in
                            cardOrPhone = formatCardNumber(newValue)
                            isCardValid = cardOrPhone.replacingOccurrences(of: " ", with: "").count == 16
                        }
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
                            .font(.system(size: 14))
                    }
                }

                Text("Barchasi")
                    .foregroundColor(.blue)
                    .onTapGesture {
                    }

                NavigationLink(destination: MoneyTransferView(cardNumber: cardOrPhone), isActive: $isCardValid) {
                    EmptyView()
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
