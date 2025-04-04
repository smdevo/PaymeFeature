//
//  SoleCurrencyView.swift
//  PaymeFeature
//
//  Created by Samandar on 04/04/25.
//

import UIKit

class SoleCurrencyView: UIView {
    
    
    
    //MARK: -UI elements
    let flagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "🏳️"
        label.font = UIFont.systemFont(ofSize: .spacing(.x8), weight: .regular)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
    let nameCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pul Birligi"
        label.font = UIFont.systemFont(ofSize: .spacing(.x4), weight: .regular)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
    let codeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "USD"
        label.font = UIFont.systemFont(ofSize: .spacing(.x6), weight: .semibold)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
    

    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Qiymati"
        label.font = UIFont.systemFont(ofSize: .spacing(.x4), weight: .regular)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
    let valueSumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "13000"
        label.font = UIFont.systemFont(ofSize: .spacing(.x6), weight: .semibold)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
    
    
    let stackCode: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let stackValue: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let stackBig: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        //stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    
    init(currency: Currency) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        flagLabel.text = currency.flag
        
        codeLabel.text = currency.code
        
        valueSumLabel.text = currency.rate
        
        
        stackCode.addArrangedSubview(nameCodeLabel)
        stackCode.addArrangedSubview(codeLabel)
        
        stackValue.addArrangedSubview(valueLabel)
        stackValue.addArrangedSubview(valueSumLabel)
        
        stackBig.addArrangedSubview(flagLabel)
        stackBig.addArrangedSubview(stackCode)
        stackBig.addArrangedSubview(stackValue)
       
        
        addSubview(stackBig)
        
        
        stackBig.leadingAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackBig.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackBig.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackBig.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
}
