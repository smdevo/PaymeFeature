//
//  BalanceView.swift
//  PaymeFeature
//
//  Created by Samandar on 04/04/25.
//

import UIKit

class BalanceView: UIStackView {
    
    // MARK: - UI Elements
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Общий баланс"
        label.font = UIFont.systemFont(ofSize: .spacing(.x4), weight: .regular)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
    private let visibleBalanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Show Balance"
        label.font = UIFont.systemFont(ofSize: .spacing(.x8), weight: .regular)
        label.textColor = UIColor.theme.labelC
        label.isHidden = true
        return label
    }()
    
    private let sumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "..."
        label.font = UIFont.systemFont(ofSize: .spacing(.x9), weight: .semibold)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
    private let currencyNamingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "сум"
        label.font = UIFont.systemFont(ofSize: .spacing(.x4), weight: .regular)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
    private let stackSum: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .bottom
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private let expenseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Расход за месяц"
        label.font = UIFont.systemFont(ofSize: .spacing(.x4), weight: .regular)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
    private let expenseSumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "160 000"
        label.font = UIFont.systemFont(ofSize: .spacing(.x4), weight: .regular)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
    private let currencyNamingForExpenseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "сум"
        label.font = UIFont.systemFont(ofSize: .spacing(.x4), weight: .regular)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
    private let stackExpense: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private let hidderStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 0
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let hidderButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.tintColor = UIColor.theme.labelC
        return button
    }()
    
    private let showerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.tintColor = UIColor.theme.labelC
        button.isHidden = true
        return button
    }()
    
    private let showCardsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = UIColor.theme.labelC
        return button
    }()
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 30
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        alignment = .fill
        distribution = .fill
        spacing = 8
                
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Method
    
    func getBalance(sum: String) {
        sumLabel.text = sum
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        stackSum.addArrangedSubview(sumLabel)
        stackSum.addArrangedSubview(currencyNamingLabel)
        
        stackExpense.addArrangedSubview(expenseLabel)
        stackExpense.addArrangedSubview(expenseSumLabel)
        stackExpense.addArrangedSubview(currencyNamingForExpenseLabel)
        
        hidderStack.addArrangedSubview(balanceLabel)
        hidderStack.addArrangedSubview(stackSum)
        hidderStack.addArrangedSubview(stackExpense)
        
        addArrangedSubview(hidderButton)
        addArrangedSubview(showerButton)
        addArrangedSubview(visibleBalanceLabel)
        addArrangedSubview(hidderStack)
        addArrangedSubview(showCardsButton)
        
        hidderButton.addTarget(self, action: #selector(hideTheBalance), for: .touchUpInside)
        showerButton.addTarget(self, action: #selector(hideTheBalance), for: .touchUpInside)
    }
    
    @objc func hideTheBalance() {
        if showerButton.isHidden {
            UIView.animate(withDuration: 0.2, animations: {
                self.hidderStack.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.hidderStack.alpha = 0
            }, completion: { _ in
                self.hidderStack.isHidden = true
                self.hidderStack.transform = .identity
                self.hidderStack.alpha = 1

                self.visibleBalanceLabel.alpha = 0
                self.visibleBalanceLabel.isHidden = false
                self.hidderButton.isHidden = true
                self.showerButton.isHidden = false

                UIView.animate(withDuration: 0.2) {
                    self.visibleBalanceLabel.alpha = 1
                }
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.visibleBalanceLabel.alpha = 0
            }, completion: { _ in
                self.visibleBalanceLabel.isHidden = true

                self.hidderStack.alpha = 0
                self.hidderStack.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.hidderStack.isHidden = false
                self.showerButton.isHidden = true
                self.hidderButton.isHidden = false

                UIView.animate(withDuration: 0.2) {
                    self.hidderStack.alpha = 1
                    self.hidderStack.transform = .identity
                }
            })
        }
    }


}
