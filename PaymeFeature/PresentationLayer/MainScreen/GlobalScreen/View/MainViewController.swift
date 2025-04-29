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
    func showBaseView(enObj: GlobalViewModel, enFamObj: FamilyViewModel)
    func showCardsView(enObj: GlobalViewModel, enFamObj: FamilyViewModel)
}


final class MainViewController: UIViewController {
    
    
    //MARK: -Dependency
    let interactor: MainInteractorProtocol
    
    //MARK: -UI elements
    
    private let balanceView = BalanceView()

    private let quickPayView = QuickPayView()
    
    private let bottomBaseView = BottomBaseView()
    
    private var familySetView = SetScrollView()
    
    
    
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
        view.addSubview(bottomBaseView)
        
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
        
        
        bottomBaseView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomBaseView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomBaseView.topAnchor.constraint(equalTo: quickPayView.bottomAnchor, constant: .spacing(.x10)).isActive = true
        bottomBaseView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
    
   
    @objc func hideShowBalance() {}
    
}

extension MainViewController: CardsButtonDelegate {
    
    func tapForCards() {
        interactor.tapForCards()
    }
    
}

extension MainViewController: MainViewProtocol {
    
    
    func showCardsView(enObj: GlobalViewModel,enFamObj: FamilyViewModel) {
        
        
        let cardsView = CardsView()
            .environmentObject(enObj)
            .environmentObject(enFamObj)
        
        
        let hostingController = UIHostingController(rootView: cardsView)
        hostingController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(hostingController, animated: true)
        
    }
    
    
    func showBaseView(enObj: GlobalViewModel, enFamObj: FamilyViewModel) {
        
        let hostingController = UIHostingController(rootView: familySetView
            .environmentObject(enObj)
            .environmentObject(enFamObj)
        )
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = UIColor.theme.backgroundColor
        
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: bottomBaseView.topAnchor,constant: .spacing(.x5)),
            hostingController.view.leadingAnchor.constraint(equalTo: bottomBaseView.leadingAnchor),
            hostingController.view.widthAnchor.constraint(equalTo: bottomBaseView.widthAnchor),
        ])
        
        hostingController.didMove(toParent: self)
    }

    func showUpdatedBalance(balance: String) {
        balanceView.getBalance(sum: balance)
    }
    
}


