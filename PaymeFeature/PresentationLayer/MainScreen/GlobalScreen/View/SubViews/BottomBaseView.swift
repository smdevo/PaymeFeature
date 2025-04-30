//
//  CurrencyView.swift
//  PaymeFeature
//
//  Created by Samandar on 04/04/25.
//


import UIKit

class BottomBaseView: UIView {
    
    init(){
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = UIColor.theme.backgroundColor
        
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
