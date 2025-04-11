//
//  MainAssembly.swift
//  PaymeFeature
//
//  Created by Samandar on 02/04/25.
//


import SwiftUI

final class Assembly {
    
    func giveMAinViewController(enObj: CardsViewModel) -> MainViewController {
        
        let presenter = MainPresenter()
        
        let interactor = MainInteractor(presenter: presenter)
        
        let view = MainViewController(interactor: interactor, enObj: enObj)
        
        presenter.view = view
        
        return view
    }
    
    
}
