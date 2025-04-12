//
//  BalanceView.swift
//  PaymeFeature
//
//  Created by Samandar on 04/04/25.
//

import UIKit

class BalanceView: UIView {
    
    
    //MARK: -UI elements
    let balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Balance"
        label.font = UIFont.systemFont(ofSize: .spacing(.x4), weight: .regular)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
   
    let sumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "150 000"
        label.font = UIFont.systemFont(ofSize: .spacing(.x9), weight: .semibold)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
    let currencyNaminglabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "sum"
        label.font = UIFont.systemFont(ofSize: .spacing(.x4), weight: .regular)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
    
    let stackSum: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .bottom
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let expenseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Expense"
        label.font = UIFont.systemFont(ofSize: .spacing(.x4), weight: .regular)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
    let currencyNamingForExpenselabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "sum"
        label.font = UIFont.systemFont(ofSize: .spacing(.x4), weight: .regular)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
    let expenseSum: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "250 100"
        label.font = UIFont.systemFont(ofSize: .spacing(.x4), weight: .regular)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
    let stackExpense: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let hidderStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let hidderButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.tintColor = UIColor.theme.labelC
        return button
    }()
    
    
    let showCardsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = UIColor.theme.labelC
        return button
    }()
    
    
    let wholeBalanceStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 30
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
            
        translatesAutoresizingMaskIntoConstraints = false
        
        stackSum.addArrangedSubview(sumLabel)
        stackSum.addArrangedSubview(currencyNaminglabel)

        stackExpense.addArrangedSubview(expenseLabel)
        stackExpense.addArrangedSubview(expenseSum)
        stackExpense.addArrangedSubview(currencyNamingForExpenselabel)

        hidderStack.addArrangedSubview(balanceLabel)
        hidderStack.addArrangedSubview(stackSum)
        hidderStack.addArrangedSubview(stackExpense)
        
        wholeBalanceStack.addArrangedSubview(hidderButton)
        wholeBalanceStack.addArrangedSubview(hidderStack)
        wholeBalanceStack.addArrangedSubview(showCardsButton)
        
        addSubview(wholeBalanceStack)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getBalance(sum: String) {
        
        sumLabel.text = sum
        
    }
    
}
