//
//  MainAssembly.swift
//  PaymeFeature
//
//  Created by Samandar on 02/04/25.
//


//Need to transfer the content in support View
//need to add focuser into textField
//need to do language localization



final class Assembly {
    
    func giveMAinViewController() -> MainViewController {
        
        let presenter = MainPresenter()
        
        let interactor = MainInteractor(presenter: presenter)
        
        let view = MainViewController(interactor: interactor)
        
        presenter.view = view
        
        return view
    }
    
    
}
