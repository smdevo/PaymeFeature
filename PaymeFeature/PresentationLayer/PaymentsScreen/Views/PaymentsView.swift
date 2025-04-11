//
//  PaymentsView.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 10/04/25.
//
import SwiftUI

// MARK: - Основной экран
struct PaymentsView: View {
    @State private var searchText: String = ""
    
    let savedPayments: [SavedPayment] = [
         SavedPayment(provider: "Ucell", description: "Мой номер", number: "+998 94 042 64 01")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "Найти")
                    .padding(.horizontal)
                
            //MARK: Saved
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Section(header: Text("Сохранённые платежи")
                                    .font(.headline)
                                    .padding(.horizontal)) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    GenericItemView(
                                        title: "Ucell\n+998 94 042 64 01",
                                        imageName: "phone.fill",
                                        color: .purple
                                    )
                                    Button(action: { }) {
                                        GenericItemView(
                                            title: "Добавить",
                                            imageName: "plus.circle",
                                            color: .blue
                                        )
                                    }
                                }
                                .padding()
                            }
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(12)
                            .padding(.horizontal)
                        }

                        //MARK: pay
                        Section {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    GenericItemView(title: "Популярное",
                                                     imageName: "star.fill",
                                                     color: .yellow)
                                    GenericItemView(title: "Мобильные\nоператоры",
                                                     imageName: "antenna.radiowaves.left.and.right",
                                                     color: .blue)
                                    GenericItemView(title: "Интернет-\nпровайдеры",
                                                     imageName: "wifi",
                                                     color: .green)
                                }
                                .padding()
                            }
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(12)
                            .padding(.horizontal)
                        } header: {
                            HStack {
                                Text("Оплата услуг")
                                    .font(.headline)
                                    .padding(.horizontal)
                                Spacer()
                                Button(action: {
                                }) {
                                    Text("Все")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        Section(header: Text("Мой дом")
                                    .font(.headline)
                                    .padding(.horizontal)
                        ) {
                            HStack {
                                GenericItemView(title: "Мой дом",
                                                 imageName: "house",
                                                 color: .blue,
                                                 showButton: true,
                                                 buttonAction: {})
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        
                        Section(header: Text("Оплата на местах")
                                    .font(.headline)
                                    .padding(.horizontal)
                        ) {
                            VStack {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("TM BARBER")
                                            .font(.subheadline)
                                            .foregroundColor(.primary)
                                        Text("улица Абдулы Кадыри, 1")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    Text("20 м")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                            }
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(12)
                            .padding(.horizontal)
                        }
                        
                        Spacer(minLength: 32)
                    }
                    .navigationBarTitle("Оплата", displayMode: .inline)
                }
            }
        }
    }
}

// MARK: - Универсальный компонент (item) для карточек
struct GenericItemView: View {
    let title: String
    let imageName: String
    let color: Color
    var showButton: Bool = false
    var buttonAction: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: imageName)
                .font(.system(size: 24))
                .foregroundColor(color)
            Text(title)
                .font(.footnote)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
            
            if showButton, let buttonAction = buttonAction {
                Button(action: buttonAction) {
                    HStack(spacing: 4) {
                        Image(systemName: "plus.circle")
                        Text("Добавить")
                            .font(.footnote)
                    }
                    .foregroundColor(color)
                }
            }
        }
        .frame(width: showButton ? 100 : 80, height: showButton ? 120 : 80)
        .background(Color(UIColor.tertiarySystemBackground))
        .cornerRadius(8)
    }
}

// MARK: - Компонент для поисковой строки
struct SearchBar: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField(placeholder, text: $text)
                .foregroundColor(.primary)
                .disableAutocorrection(true)
        }
        .padding(8)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
    }
}

#Preview {
    PaymentsView()
}
