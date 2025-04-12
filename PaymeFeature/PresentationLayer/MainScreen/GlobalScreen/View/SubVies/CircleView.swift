//
//  CircleView.swift
//  PaymeFeature
//
//  Created by Samandar on 04/04/25.
//

import UIKit

class CircleView: UIView {
    
    //MARK: -UI elements
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Kartalarim"
        label.font = UIFont.systemFont(ofSize: .spacing(.x5), weight: .regular)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
   
    let backView: UIView = {
        let bView = UIView()
        bView.translatesAutoresizingMaskIntoConstraints = false
        bView.backgroundColor = UIColor.white
        bView.layer.cornerRadius = 35
        return bView
    }()
    
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "creditcard.fill")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.theme.unselectedTabbarItem
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    let stackCust: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    
    init(imageName: String, strLabel: String) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)

        
        nameLabel.text = strLabel
        
        
        backView.addSubview(imageView)
        
        stackCust.addArrangedSubview(backView)
        stackCust.addArrangedSubview(nameLabel)
    
        widthAnchor.constraint(equalToConstant: 120).isActive = true
        backView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        backView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        imageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: backView.centerXAnchor).isActive = true
    

        
        addSubview(stackCust)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
