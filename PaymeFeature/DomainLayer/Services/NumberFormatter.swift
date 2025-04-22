//
//  NumberFormatter.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 22/04/25.
//

import Foundation
import SwiftUI


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

extension String {
    var removingTrailingZeroDecimal: String {
        if hasSuffix(".0") {
            return String(dropLast(2))
        }
        return self
    }
    
   
        var maskedCardNumber: String {
            let digits = self.replacingOccurrences(of: " ", with: "")
            guard digits.count >= 12 else { return self }
            var chars = Array(digits)
            for i in 8..<12 {
                chars[i] = "*"
            }
            
            let masked = String(chars)
            let groups = stride(from: 0, to: masked.count, by: 4).map { idx -> String in
                let start = masked.index(masked.startIndex, offsetBy: idx)
                let end = masked.index(start, offsetBy: 4, limitedBy: masked.endIndex) ?? masked.endIndex
                return String(masked[start..<end])
            }
            return groups.joined(separator: " ")
        }
    

}



extension View {
    func textWithBlackBorder() -> some View {
        self.shadow(color: .black, radius: 3, x: 3, y: 3)
    }
}
