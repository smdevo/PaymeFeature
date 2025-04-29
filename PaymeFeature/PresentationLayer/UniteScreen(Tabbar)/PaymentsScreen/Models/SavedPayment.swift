//
//  SavedPayment.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 10/04/25.
//

import SwiftUI

// MARK: - Модель для сохранённого платежа
struct SavedPayment: Identifiable {
    let id = UUID()
    let provider: String
    let description: String
    let number: String
}
