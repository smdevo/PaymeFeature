//
//  AuthScreen.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

class ServicesViewModel: ObservableObject {
    @Published var services: [Service] = []
    
    init() {
        loadServices()
    }
    
    private func loadServices() {
        services = [
            Service(id: UUID(), name: "Заказ еды", description: "Закажите еду онлайн", iconName: "fork.knife", iconColor: .red),
            Service(id: UUID(), name: "Кредит", description: "Получите кредит от TBC Bank онлайн", iconName: "doc.text.fill", iconColor: .yellow),
            Service(id: UUID(), name: "payme plus", description: "Одна подписка — много возможностей", iconName: "plus.circle.fill", iconColor: .orange),
            Service(id: UUID(), name: "payme tickets", description: "Покупка билетов на различные мероприятия", iconName: "ticket.fill", iconColor: .blue),
            Service(id: UUID(), name: "payme avia", description: "Кэшбэк 5% при покупке билетов с Salom Card", iconName: "airplane", iconColor: .yellow),
            Service(id: UUID(), name: "Справки и госуслуги", description: "", iconName: "building.2.fill", iconColor: .gray),
            Service(id: UUID(), name: "Напоминания", description: "Установите напоминание для уведомления об оплате", iconName: "alarm.fill", iconColor: .green),
            Service(id: UUID(), name: "Оплата на расчётный счёт", description: "", iconName: "creditcard.fill", iconColor: .blue)
        ]
    }
    
    
}
