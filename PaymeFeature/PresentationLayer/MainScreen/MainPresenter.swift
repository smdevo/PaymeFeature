//
//  MainPresenterr.swift
//  PaymeFeature
//
//  Created by Samandar on 02/04/25.
//



protocol MainPresenterProtocol {
    
    func presentCurrencies(currencies: [Currency])
    
}


final class MainPresenter {
    
    weak var view: MainViewProtocol?
    
    
}


extension MainPresenter: MainPresenterProtocol {
    
    
    func presentCurrencies(currencies: [Currency]) {
        view?.showCurrencies(currencies: currencies)
    }
    
    
    
}
