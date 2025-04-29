//
//  familySubscription.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 29/04/25.
//

import SwiftUI

struct FamilySubscriptionView: View {
    @State private var selectedPlan = 0
    private let plans = [
        (title: "Для семьи", price: "24 990 сум/месяц"),
        (title: "Базовый", price: "4 990 сум/месяц")
    ]
    private let features = [
        (icon: "chart.pie.fill", title: "Мониторинг всех расходов", subtitle: "Анализ по категориям и диаграммам"),
        (icon: "percent", title: "Беспроцентные переводы детям", subtitle: "На детские счета до 5 000 000 UZS")
    ]
    private let gift = (
        title: "Yandex Plus",
        description: "60 дней подписки бесплатно. Kinopoisk, Yandex Music, Yandex Books и кешбэк баллами",
        points: "+9 000 баллов Plus в Yandex Go и Yandex Eats"
    )

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("Детский счёт — ")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.top)
                Text("учимся тратить правильно")
                    .font(.title)
                    .fontWeight(.semibold)
                    

                
                TabView(selection: $selectedPlan) {
                    ForEach(plans.indices, id: \.self) { idx in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(idx == 0 ? Color.green.opacity(0.8) : Color.blue.opacity(0.8))
                                .frame(height: 120)

                            if idx == 0 {
                                Text("Рекомендуем")
                                    .font(.caption2).bold()
                                    .padding(6)
                                    .background(Color.white.opacity(0.7))
                                    .cornerRadius(8)
                                    .offset(x: 270, y: -36)
                            }

                            VStack(alignment: .leading, spacing: 8) {
                                Text(plans[idx].title)
                                    .font(.title2).bold().foregroundColor(.white)
                                Text(plans[idx].price)
                                    .font(.headline).foregroundColor(.white)
                                Text(idx == 0 ? "Счёт который учит ребёнка правильно тратить" : "Стандартная подписка")
                                    .font(.subheadline).foregroundColor(.white.opacity(0.9))
                            }
                            
                            .padding()
                        }
                        .padding(.horizontal)
                        .tag(idx)
                    }
                }
                .frame(height: 140)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))

                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(features, id: \.title) { feature in
                            HStack(alignment: .top, spacing: 12) {
                                Image(systemName: feature.icon)
                                    .font(.title2)
                                    .foregroundColor(.accentColor)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(feature.title)
                                        .font(.body).bold()
                                    Text(feature.subtitle)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemBackground)).shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2))
                            .padding(.horizontal)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(gift.title)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            Text(gift.description)
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                            Text(gift.points)
                                .font(.footnote).bold()
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                .cornerRadius(12)
                        )
                        .padding(.horizontal)
                    }
                }

                
                Button(action: {
   
                }) {
                    Text("Подписаться за \(plans[selectedPlan].price)")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.paymeC)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                .padding(.bottom)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("payme plus")
                        .font(.subheadline).foregroundColor(.black)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

struct FamilySubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        FamilySubscriptionView()
    }
}
