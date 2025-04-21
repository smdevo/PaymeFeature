//
//  FamilyModel.swift
//  PaymeFeature
//
//  Created by Samandar on 11/04/25.
//
import SwiftUI

struct FamilyModel: Codable {
    var cards: [VirtualCardModel?]
    let id: String
}
