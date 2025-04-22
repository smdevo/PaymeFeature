//
//  NumberFormatter.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 22/04/25.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.groupingSeparator = " "
        return f
    }()
}

extension BinaryInteger {
    var formattedWithSeparator: String {
        Formatter.withSeparator.string(for: self) ?? "\(self)"
    }
}
