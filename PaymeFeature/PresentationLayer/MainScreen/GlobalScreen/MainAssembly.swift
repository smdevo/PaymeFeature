//
//  MainAssembly.swift
//  PaymeFeature
//
//  Created by Samandar on 02/04/25.
//


import SwiftUI

final class Assembly {
    
    func giveMAinViewController(enObj: GlobalViewModel) -> MainViewController {
        
        let presenter = MainPresenter()
        
        let interactor = MainInteractor(presenter: presenter, enObj: enObj)
        
        let view = MainViewController(interactor: interactor)
        
        presenter.view = view
        
        return view
    }
    
    
}
