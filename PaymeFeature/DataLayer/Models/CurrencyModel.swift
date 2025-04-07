//
//  CurrencyModel.swift
//  PaymeFeature
//
//  Created by Samandar on 04/04/25.
//


import Foundation

struct Currency: Codable, Identifiable {
    let id: Int
    let code: String     //
    let currency: String
    let nameRU: String
    let nameUZ: String
    let nameUZC: String
    let nameEN: String
    let nominal: String //
    let rate: String
    let diff: String    //
    let date: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case code = "Code"
        case currency = "Ccy"
        case nameRU = "CcyNm_RU"
        case nameUZ = "CcyNm_UZ"
        case nameUZC = "CcyNm_UZC"
        case nameEN = "CcyNm_EN"
        case nominal = "Nominal"
        case rate = "Rate"
        case diff = "Diff"
        case date = "Date"
    }
    
   
    
    var flag: String {
        let countryCode = String(currency.dropLast())
        return countryCodeToFlag(countryCode)
    }
    
    /// Converts country code to flag emoji
    private func countryCodeToFlag(_ countryCode: String) -> String {
        guard countryCode.count == 2 else { return "🏳️" } // Default flag
        return countryCode.uppercased().unicodeScalars.map {
            String(UnicodeScalar(127397 + $0.value)!)
        }.joined()
    }
}



struct Currency1: Codable {
    let id: Int
    let currency: String
    let nameEN: String
    let rate: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case currency = "Ccy"
        case nameEN = "CcyNm_EN"
        case rate = "Rate"
    }
    
    /// Computed property to return the flag emoji based on currency code.
    var flag: String {
        let countryCode = getCountryCode(from: currency)
        return countryCodeToFlag(countryCode)
    }
    
    /// Maps currency code to a country code
    private func getCountryCode(from currency: String) -> String {
        let currencyToCountry: [String: String] = [
            "USD": "US", "EUR": "EU", "RUB": "RU",
            "GBP": "GB", "CNY": "CN", "JPY": "JP"
        ]
        return currencyToCountry[currency] ?? ""
    }
    
    /// Converts country code to flag emoji
    private func countryCodeToFlag(_ countryCode: String) -> String {
        guard countryCode.count == 2 else { return "🏳️" } // Default flag
        return countryCode.uppercased().unicodeScalars.map {
            String(UnicodeScalar(127397 + $0.value)!)
        }.joined()
    }
}
