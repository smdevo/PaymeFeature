//
//  MainViewController.swift
//  PaymeFeature
//
//  Created by Samandar on 02/04/25.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    
}


final class MainViewController: UIViewController {

    //MARK: -Dependency
    let interactor: MainInteractorProtocol
    
    
    //MARK: -UI elements
    let balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Umumiy balans"
        label.font = UIFont.systemFont(ofSize: .spacing(.x4), weight: .regular)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
   
    let sumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "280 045"
        label.font = UIFont.systemFont(ofSize: .spacing(.x9), weight: .semibold)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
    let currencyNaminglabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "so'm"
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
        label.text = "Chiqim -"
        label.font = UIFont.systemFont(ofSize: .spacing(.x4), weight: .regular)
        label.textColor = UIColor.theme.labelC
        return label
    }()
    
    let currencyNamingForExpenselabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "so'm"
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
    
    
    let showBalanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Balansni ko'rsatish"
        label.font = UIFont.systemFont(ofSize: .spacing(.x6), weight: .semibold)
        label.textColor = UIColor.theme.labelC
        label.isHidden = true
        return label
    }()
    
    
    let wholeBalanceStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
   
    
    
    //MARK: -Init
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        interactor.onviewDidLoad()
    }
    
    init(interactor: MainInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: -Functions
    
    private func setUpView() {
        
        view.backgroundColor = UIColor.theme.paymeC
        
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
        wholeBalanceStack.addArrangedSubview(showBalanceLabel)
        wholeBalanceStack.addArrangedSubview(showCardsButton)
        
        view.addSubview(wholeBalanceStack)
        
        hidderButton.addTarget(self, action: #selector(hideShowBalance), for: .touchUpInside)
        
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        
        
        
        wholeBalanceStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .spacing(.x10)).isActive = true
        wholeBalanceStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(.spacing(.x10))).isActive = true
        wholeBalanceStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        
        
    }
    
    
    @objc func hideShowBalance() {
        
        hidderStack.isHidden = true
        
        showBalanceLabel.isHidden = false
        
        
    }
    
}

extension MainViewController: MainViewProtocol {
    
    
}
