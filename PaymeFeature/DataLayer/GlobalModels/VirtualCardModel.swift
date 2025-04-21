//
//  VirtualCardModel.swift
//  PaymeFeature
//
//  Created by Samandar on 11/04/25.
//

struct VirtualCardModel: Codable {
    var id: String = ""
    var name: String = ""
    var number: String = ""
    var ownerPhoneNumber: String = ""
    var balance: String = ""
    var limit: String?
}


