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
    case x11 = 44
    case x12 = 48
    case x13 = 52
    case x14 = 56
    case x15 = 60
    case x16 = 64
    case x17 = 68
    case x18 = 72
    case x19 = 76
    case x20 = 80
}

extension CGFloat {
    static func spacing(_ space: PaymeSpaces) -> CGFloat {
        space.rawValue
    }
}

