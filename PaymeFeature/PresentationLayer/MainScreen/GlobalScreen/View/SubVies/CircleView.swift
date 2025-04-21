//
//  CircleView.swift
//  PaymeFeature
//
//  Created by Samandar on 04/04/25.
//

import UIKit

class CircleButton: UIButton {
    
    // MARK: - UI Elements
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Kartalarim"
        label.font = UIFont.systemFont(ofSize: .spacing(.x5), weight: .regular)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
    private let backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 35
        return view
    }()
    
    private let myimageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "creditcard.fill")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.theme.quickPayColor
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let stackCust: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    weak var delegate: CardsButtonDelegate?
    
    // MARK: - Initializer
    init(imageName: String, strLabel: String) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear  // Make background clear for custom views
        
        myimageView.image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        nameLabel.text = strLabel
        
        backView.addSubview(myimageView)
        stackCust.addArrangedSubview(backView)
        stackCust.addArrangedSubview(nameLabel)
        
        addSubview(stackCust)
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 120),
            
            backView.heightAnchor.constraint(equalToConstant: 70),
            backView.widthAnchor.constraint(equalToConstant: 70),
            
            myimageView.heightAnchor.constraint(equalToConstant: 50),
            myimageView.widthAnchor.constraint(equalToConstant: 50),
            myimageView.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            myimageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            
            stackCust.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackCust.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Button Action (Example)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        delegate?.tapForCards()
    }
}
