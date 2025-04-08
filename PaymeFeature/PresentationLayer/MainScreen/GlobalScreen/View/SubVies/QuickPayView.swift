//
//  QuickPayView.swift
//  PaymeFeature
//
//  Created by Samandar on 04/04/25.
//

import UIKit

class QuickPayView: UIView {
    
    //MARK: -UI elements
    let balanceBtn = CircleView(imageName: "creditcard", strLabel: "Kartalarim")
    
    let goBtn = CircleView(imageName: "circle.hexagongrid.circle.fill", strLabel: "Payme Go")
    
    let qrBtn = CircleView(imageName: "qrcode.viewfinder", strLabel: "QR To'lov")
    
    let wholeQuickStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        //stackView.spacing = 30
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    
    
    init() {
        super.init(frame: .zero)
        
        
        translatesAutoresizingMaskIntoConstraints = false
        
        wholeQuickStack.addArrangedSubview(balanceBtn)
        wholeQuickStack.addArrangedSubview(goBtn)
        wholeQuickStack.addArrangedSubview(qrBtn)
        
        addSubview(wholeQuickStack)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
