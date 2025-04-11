//
//  QuickPayView.swift
//  PaymeFeature
//
//  Created by Samandar on 04/04/25.
//

import UIKit

class QuickPayView: UIView {
    
    //MARK: -UI elements
    let balanceBtn = CircleView(imageName: "creditcard", strLabel: "My cards")
    
    let goBtn = CircleView(imageName: "circle.hexagongrid.circle.fill", strLabel: "Payme Go")
    
    let qrBtn = CircleView(imageName: "qrcode.viewfinder", strLabel: "QR Payment")

    
    let wholeQuickStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    weak var delegate: CardsButtonDelegate?
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        wholeQuickStack.addArrangedSubview(balanceBtn)
        wholeQuickStack.addArrangedSubview(goBtn)
        wholeQuickStack.addArrangedSubview(qrBtn)
        
        addSubview(wholeQuickStack)
        
        balanceBtn.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(balanceBtnTapped))
        balanceBtn.addGestureRecognizer(tapGesture)
        balanceBtn.isUserInteractionEnabled = true
        
        
        balanceBtn.backgroundColor = .red.withAlphaComponent(0.3)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func balanceBtnTapped() {
        delegate?.tapForCards()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.tapForCards()
    }

}
