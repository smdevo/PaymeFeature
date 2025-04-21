//
//  UserModel.swift
//  PaymeFeature
//
//  Created by Samandar on 11/04/25.
//


struct UserModel: Codable, Identifiable, Equatable {
    let name: String
    let number: String
    let password: String
    let date: Int
    var familyId: String
    let role: Bool
    let balance: String
    let id: String
    var invitation: Bool
    var invitedFamilyId: String?
    let cardNumber: String
}
