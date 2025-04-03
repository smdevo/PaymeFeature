//
//  ViewController.swift
//  PaymeFeature
//
//  Created by Samandar on 02/04/25.
//

import UIKit
import SwiftUI

class UniteViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        createOtherVCs()
    }
    
    func createOtherVCs() {
        
        setupTabBarAppearance()
        
        let main = Assembly().giveMAinViewController()
        main.tabBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "house"), tag: 0)


        let transfers = UIHostingController(rootView: TransfersView())
        transfers.tabBarItem = UITabBarItem(title: "Transfers", image: UIImage(systemName: "arrow.left.arrow.right"), tag: 1)

        let payment = UIHostingController(rootView: PaymentsView())
        payment.tabBarItem = UITabBarItem(title: "Payment", image: UIImage(systemName: "wallet.bifold.fill"), tag: 2)

        let service = UIHostingController(rootView: ServiceView())
        service.tabBarItem = UITabBarItem(title: "Services", image: UIImage(systemName: "square.grid.2x2"), tag: 3)

        let support = UIHostingController(rootView: SupportView())
        support.tabBarItem = UITabBarItem(title: "Support", image: UIImage(systemName: "person.crop.circle"), tag: 4)


        viewControllers = [main, transfers, payment, service, support]
        
    }
    
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.theme.tabbarBC
        
        // Customize tab bar item text & icon color
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.theme.paymeC, .font: UIFont.boldSystemFont(ofSize: 12)]
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.theme.paymeC
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.theme.unselectedTabbarItem, .font: UIFont.systemFont(ofSize: 12)]
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.theme.unselectedTabbarItem
        
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
}


