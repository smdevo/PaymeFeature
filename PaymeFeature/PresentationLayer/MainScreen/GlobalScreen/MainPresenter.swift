//
//  MainPresenterr.swift
//  PaymeFeature
//
//  Created by Samandar on 02/04/25.
//



protocol MainPresenterProtocol {
    
    func presentBalance(balance: String)
    func presentBaseView(enObj: GlobalViewModel, enFamObj: FamilyViewModel)
    func presentCardsView(enObj: GlobalViewModel, enFamObj: FamilyViewModel)
}


final class MainPresenter {
    
    weak var view: MainViewProtocol?
    
    
}


extension MainPresenter: MainPresenterProtocol {
    
    
    func presentCardsView(enObj: GlobalViewModel,enFamObj: FamilyViewModel) {
        view?.showCardsView(enObj: enObj, enFamObj: enFamObj)
    }
    
    
    
    func presentBaseView(enObj: GlobalViewModel, enFamObj: FamilyViewModel) {
        view?.showBaseView(enObj: enObj, enFamObj: enFamObj)
    }
    
    
    
    func presentBalance(balance: String) {
        view?.showUpdatedBalance(balance: balance)
    }

}
