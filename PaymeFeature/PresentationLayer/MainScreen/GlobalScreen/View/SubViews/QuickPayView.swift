//
//  QuickPayView.swift
//  PaymeFeature
//
//  Created by Samandar on 04/04/25.
//

import UIKit


class QuickPayView: UIStackView {
    
    //MARK: -UI elements
    
    let balanceBtn = CircleButton(imageName: "creditcard", strLabel: "Мои карты")
    
    let goBtn = CircleButton(imageName: "circle.hexagongrid.circle.fill", strLabel: "Payme Go")
    
    let qrBtn = CircleButton(imageName: "qrcode.viewfinder", strLabel: "QR оплата")
    
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        alignment = .center
        distribution = .equalSpacing
        
        
        addArrangedSubview(balanceBtn)
        addArrangedSubview(goBtn)
        addArrangedSubview(qrBtn)
        
        goBtn.isUserInteractionEnabled = false
        qrBtn.isUserInteractionEnabled = false
        
        
        balanceBtn.addTarget(self, action: #selector(balanceBtnTapped), for: .touchUpInside)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func balanceBtnTapped() {
       
    }
    
    
}

