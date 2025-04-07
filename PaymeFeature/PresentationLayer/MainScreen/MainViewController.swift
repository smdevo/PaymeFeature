//
//  MainViewController.swift
//  PaymeFeature
//
//  Created by Samandar on 02/04/25.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    
    func showCurrencies(currencies: [Currency])
    
}


final class MainViewController: UIViewController {

    //MARK: -Dependency
    let interactor: MainInteractorProtocol
    
    var currencies: [Currency] = []
    
    //MARK: -UI elements
    
    private let balanceView = BalanceView()

    private let quickPayView = QuickPayView()
    
    private let currencyView = CurrencyView()
    
    //private var currencySetView = CurrencySetView()
    
    
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
        view.addSubview(balanceView)
        view.addSubview(quickPayView)
        view.addSubview(currencyView)
       // currencyView.addSubview(currencySetView)
       
        //currencySetView.isHidden = true
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
    
        balanceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .spacing(.x10)).isActive = true
        balanceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(.spacing(.x10))).isActive = true
        balanceView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        balanceView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
    
        
        quickPayView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .spacing(.x10)).isActive = true
        quickPayView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(.spacing(.x10))).isActive = true
        quickPayView.topAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: 60).isActive = true
        quickPayView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        
        
        currencyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        currencyView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        currencyView.topAnchor.constraint(equalTo: quickPayView.bottomAnchor, constant: 50).isActive = true
        currencyView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
//        currencySetView.leadingAnchor.constraint(equalTo: currencyView.leadingAnchor).isActive = true
//        currencySetView.trailingAnchor.constraint(equalTo: currencyView.trailingAnchor).isActive = true
//        currencySetView.topAnchor.constraint(equalTo: currencyView.topAnchor, constant: 50).isActive = true
//        currencySetView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
    }
    
    
    @objc func hideShowBalance() {
            
        
    }
    
}

extension MainViewController: MainViewProtocol {
    
    
    func showCurrencies(currencies: [Currency]) {
        self.currencies = currencies
        
        currencies.forEach { currency in
            print(currency.flag)
        }
        
      //  currencySetView.setContents(currencies: currencies)
    }
    

}
