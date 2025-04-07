//
//  AuthScreen.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import Foundation

enum Sender: String {
    case user, assistant
}

struct Message: Identifiable {
    let id = UUID()
    let sender: Sender
    let text: String
}
