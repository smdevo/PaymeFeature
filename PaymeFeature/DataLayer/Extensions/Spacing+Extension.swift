//
//  Spacing+Extension.swift
//
//

import Foundation

enum PaymeSpaces: CGFloat {
    case x1 = 4
    case x2 = 8
    case x3 = 12
    case x4 = 16
    case x5 = 20
    case x6 = 24
    case x7 = 28
    case x8 = 32
    case x9 = 36
    case x10 = 40
}

extension CGFloat {
    static func spacing(_ space: PaymeSpaces) -> CGFloat {
        space.rawValue
    }
}

