//
//  MainInteractor.swift
//  PaymeFeature
//
//  Created by Samandar on 02/04/25.
//


protocol MainInteractorProtocol {
    
    func onviewDidLoad()
}


final class MainInteractor {
    
    let currencyNetworkingService: CurrencyNetworkingService = CurrencyNetworkingService()
    
    let presenter: MainPresenterProtocol
    
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
}


extension MainInteractor: MainInteractorProtocol {
    
    func onviewDidLoad() {
        print("Interactor is working")
        
        fetchCurrencyData()
    }
    
    private func fetchCurrencyData() {
        
        currencyNetworkingService.fetchSelectedCurrencies(codes: ["USD", "EUR", "RUB","GBP","JPY"]) { [weak self] currencies in
            
            guard let currencies = currencies
            else {
                print("Failed to fetch currency data.")
                return
            }
            
            
            self?.presenter.presentCurrencies(currencies: currencies)
            
        }

        
    }
    
    
}
