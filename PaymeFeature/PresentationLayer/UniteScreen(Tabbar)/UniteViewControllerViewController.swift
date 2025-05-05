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
        
        let globalVM = GlobalViewModel()
        
        let main = UINavigationController(rootViewController: (Assembly().giveMAinViewController(enObj: globalVM)))
        
        main.tabBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "house"), tag: 0)

        let transfers = UIHostingController(rootView: TransfersView())//.environmentObject(globalVM))
        transfers.tabBarItem = UITabBarItem(title: "Transfers", image: UIImage(systemName: "arrow.left.arrow.right"), tag: 1)

        let service = UIHostingController(rootView: ServiceView())//.environmentObject(globalVM))
        service.tabBarItem = UITabBarItem(title: "Services", image: UIImage(systemName: "square.grid.2x2"), tag: 3)

        let monitoring = UIHostingController(rootView: MonitoringView())//.environmentObject(globalVM))
        monitoring.tabBarItem = UITabBarItem(title: "Monitoring", image: UIImage(systemName: "chart.bar"), tag: 4)

        let payment = UIHostingController(rootView: PaymentsView())//.environmentObject(globalVM))
        payment.tabBarItem = UITabBarItem(title: "Payment", image: UIImage(systemName: "wallet.bifold.fill"), tag: 5)

        viewControllers = [main,transfers,payment, service, monitoring]
        
    }
    
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.theme.tabbarBC
        
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.theme.paymeC, .font: UIFont.boldSystemFont(ofSize: 12)]
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.theme.paymeC
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.theme.unselectedTabbarItem, .font: UIFont.systemFont(ofSize: 12)]
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.theme.unselectedTabbarItem
        
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
}


