//
//  MainInteractor.swift
//  PaymeFeature
//
//  Created by Samandar on 02/04/25.
//
import Combine

protocol MainInteractorProtocol {
    
    func onviewDidLoad()
    func tapForCards()
}


final class MainInteractor {
    
    var cancellables = Set<AnyCancellable>()
    
    let presenter: MainPresenterProtocol
    
    let enObj: GlobalViewModel
    
    let enFamObj: FamilyViewModel
    
    init(presenter: MainPresenterProtocol, enObj: GlobalViewModel, enfamObj: FamilyViewModel) {
        self.presenter = presenter
        self.enObj = enObj
        self.enFamObj = enfamObj
    }
    
}


extension MainInteractor: MainInteractorProtocol {
    
    
    
    func onviewDidLoad() {
        
        upDateTheBalance()
        setUpBaseView()
    }
    
    
    func tapForCards() {
        presenter.presentCardsView(enObj: enObj, enFamObj: enFamObj)
    }
    
    private func upDateTheBalance() {
        
        enObj.$currentUser
            .sink { [weak self] user in
                if let intBalance = Int(user?.balance ?? "...") {
                self?.presenter.presentBalance(balance: intBalance.formattedWithSeparator)
                }
            }
            .store(in: &cancellables)
    }
    
    
    private func setUpBaseView() {
        
        presenter.presentBaseView(enObj: enObj, enFamObj: enFamObj)
        
    }
    
}
