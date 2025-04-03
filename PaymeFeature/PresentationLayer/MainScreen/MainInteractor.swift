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
    
    let presenter: MainPresenterProtocol
    
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
}


extension MainInteractor: MainInteractorProtocol {
    
    func onviewDidLoad() {
        print("Interactor is working")
    }
    
}
