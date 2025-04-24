//
//  MainAssembly.swift
//  PaymeFeature
//
//  Created by Samandar on 02/04/25.
//


import Foundation

final class Assembly {
    
    func giveMAinViewController(enObj: GlobalViewModel) -> MainViewController {
        
        let familyeNOb = FamilyViewModel()
        
        let presenter = MainPresenter()
        
        let interactor = MainInteractor(presenter: presenter, enObj: enObj, enfamObj: familyeNOb)
        
        let view = MainViewController(interactor: interactor)
        
        presenter.view = view
        
        return view
    }
    
    
}
