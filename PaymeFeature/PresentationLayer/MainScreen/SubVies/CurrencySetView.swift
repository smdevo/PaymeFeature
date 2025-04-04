//
//  CurrencySetView.swift
//  PaymeFeature
//
//  Created by Samandar on 04/04/25.
//

import UIKit

class CurrencySetView: UIView {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let containerView: UIStackView = {
        let containerView = UIStackView()
        containerView.axis = .horizontal
        containerView.spacing = 16
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scrollView)
        scrollView.addSubview(containerView)

        setConst()  // Call the function to apply constraints
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setConst() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 150),
            
            containerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            containerView.widthAnchor.constraint(greaterThanOrEqualTo: scrollView.widthAnchor)  // Ensures horizontal scrolling
        ])
    }

    func setContents(currencies: [Currency]) {
        for currency in currencies {
            let currencyView = SoleCurrencyView(currency: currency)
            currencyView.backgroundColor = .blue
            currencyView.layer.cornerRadius = 20
            currencyView.translatesAutoresizingMaskIntoConstraints = false
            
            currencyView.widthAnchor.constraint(equalToConstant: 100).isActive = true  // Adjusted width
            currencyView.heightAnchor.constraint(equalToConstant: 150).isActive = true
            
            containerView.addArrangedSubview(currencyView)
        }
    }
}
