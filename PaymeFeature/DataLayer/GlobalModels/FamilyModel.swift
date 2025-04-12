//
//  FamilyModel.swift
//  PaymeFeature
//
//  Created by Samandar on 11/04/25.
//
import SwiftUI

struct FamilyModel: Codable {
    let name: String
    var members: [String]
    var virtualcard: VirtualCardModel?
    let id: String
}
