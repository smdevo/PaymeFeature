//
//  ForColor.swift
//  PaymeFeature
//
//  Created by Samandar on 02/04/25.
//


import SwiftUI

extension UIColor {
    static var theme = ColorThemeK()
}

extension Color {
    
    static var theme = ColorTheme()
    
}


struct ColorTheme {
    let backgroundColor = Color("backgroundC")
    let tabbarBC = Color("tabbarBC")
    let paymeC = Color("paymeC")
    let unselectedTabbarItem = Color("unselectedTabbarItem")
    let labelC = Color("labelC")

}

struct ColorThemeK {
    let backgroundColor = UIColor(named: "backgroundC") ?? .systemBackground
    let tabbarBC = UIColor(named: "tabbarBC") ?? .secondarySystemBackground
    let paymeC = UIColor(named: "paymeC") ?? .green
    let unselectedTabbarItem = UIColor(named: "unselectedTabbarItem") ?? .gray
    let labelC = UIColor(named: "labelC") ?? .white
  
}


