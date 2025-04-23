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
    
    @EnvironmentObject var evm: GlobalViewModel
    
    
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
                    Text("Перевод средств")
                        .font(.title3)
                        .bold()
                    Spacer()
                    
                }
                .padding(.top)
                
                Text("Кому:")
                    .font(.headline)
                
                Text("Номер карты или телефона")
                    .foregroundStyle(.gray)
                    .font(.system(size: 14))
                
                HStack {
                    Image(systemName: "creditcard")
                        .foregroundColor(.gray)
                    
                    
    
                    TextField("Номер карты или телефона", text: $cardOrPhone)
                        .keyboardType(.numberPad)
                        .font(.system(size: 14))
                        .onChange(of: cardOrPhone) { oldValue, newValue in
                            cardOrPhone = formatCardNumber(newValue)
                            isCardValid = cardOrPhone.replacingOccurrences(of: " ", with: "").count == 16
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
                        Text("Добавить")
                            .foregroundColor(.blue)
                            .font(.system(size: 14))
                    }
                }
                
                Text("Все получатели")
                    .foregroundColor(.blue)
                    .onTapGesture {
                    }
                
                NavigationLink(destination: MoneyTransferView(cardNumber: cardOrPhone)) {
                    EmptyView()
                }
                
                
                VStack(spacing: 12) {
                    NavigationLink(destination: PhoneTransferScreen()) {
                        HStack {
                            Image(systemName: "phone")
                            Text("По номеру телефона")
                                .foregroundColor(.primary)
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
                            Text("Перевод на мою карту")
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
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
        Text("Перевод по номеру телефона")
            .navigationTitle("По номеру телефона")
    }
}

struct SelfTransferScreen: View {
    var body: some View {
        Text("Перевод на мою карту")
            .navigationTitle("На мою карту")
    }
}




#Preview {
    TransfersView()
}
