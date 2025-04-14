//
//  MainPresenterr.swift
//  PaymeFeature
//
//  Created by Samandar on 02/04/25.
//



protocol MainPresenterProtocol {
    
    func presentBalance(balance: String)
    func presentBaseView(enObj: GlobalViewModel)
    func presentCardsView(enObj: GlobalViewModel)
}


final class MainPresenter {
    
    weak var view: MainViewProtocol?
    
    
}


extension MainPresenter: MainPresenterProtocol {
    
    
    func presentCardsView(enObj: GlobalViewModel) {
        view?.showCardsView(enObj: enObj)
    }
    
    
    
    func presentBaseView(enObj: GlobalViewModel) {
        view?.showBaseView(enObj: enObj)
    }
    
    
    
    func presentBalance(balance: String) {
        view?.showUpdatedBalance(balance: balance)
    }

}
