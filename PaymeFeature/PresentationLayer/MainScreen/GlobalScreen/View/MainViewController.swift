//
//  MainViewController.swift
//  PaymeFeature
//
//  Created by Samandar on 02/04/25.
//

import UIKit
import SwiftUI
import Combine


protocol CardsButtonDelegate: AnyObject {
    func tapForCards()
}


protocol MainViewProtocol: AnyObject {
    
    func showUpdatedBalance(balance: String)
    func showBaseView(enObj: GlobalViewModel)
    func showCardsView(enObj: GlobalViewModel)
}


final class MainViewController: UIViewController {
    
    
    
    //MARK: -Dependency
    let interactor: MainInteractorProtocol
    
    //MARK: -UI elements
    
    private let balanceView = BalanceView()

    private let quickPayView = QuickPayView()
    
    private let currencyView = CurrencyView()
    
    private var currencyScrollView = SetScrollView()
    
    
    
    //MARK: -Init
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        interactor.onviewDidLoad()
    }
    
    
   
    
    init(interactor: MainInteractor) {
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
        
        quickPayView.balanceBtn.delegate = self
               
        setUpConstraints()
        
    }

    
    
    private func setUpConstraints() {
    
        balanceView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        balanceView.topAnchor.constraint(equalTo: view.topAnchor, constant: .spacing(.x14)).isActive = true
        balanceView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
    
        
        
        quickPayView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        quickPayView.topAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: .spacing(.x7)).isActive = true
        quickPayView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        
        
        currencyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        currencyView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        currencyView.topAnchor.constraint(equalTo: quickPayView.bottomAnchor, constant: .spacing(.x10)).isActive = true
        currencyView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
    
   
    @objc func hideShowBalance() {}
    
}

extension MainViewController: CardsButtonDelegate {
    
    func tapForCards() {
        interactor.tapForCards()
    }
    
}

extension MainViewController: MainViewProtocol {
    
    
    func showCardsView(enObj: GlobalViewModel) {
        let cardsView = CardsView().environmentObject(enObj)
        
        let hostingController = UIHostingController(rootView: cardsView)
        
        navigationController?.pushViewController(hostingController, animated: true)
    }
    
    
    func showBaseView(enObj: GlobalViewModel) {
        
        let hostingController = UIHostingController(rootView: currencyScrollView.environmentObject(enObj))
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = UIColor.theme.backgroundColor
        
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: currencyView.topAnchor,constant: .spacing(.x5)),
            hostingController.view.leadingAnchor.constraint(equalTo: currencyView.leadingAnchor),
            hostingController.view.widthAnchor.constraint(equalTo: currencyView.widthAnchor),
        ])
        
        hostingController.didMove(toParent: self)
    }

    func showUpdatedBalance(balance: String) {
        balanceView.getBalance(sum: balance)
    }
    
}
