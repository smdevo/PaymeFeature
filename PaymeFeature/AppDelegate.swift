//
//  AppDelegate.swift
//  PaymeFeature
//
//  Created by Samandar on 02/04/25.
//

import UIKit
import CoreData
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        

        
        if window == nil {
            window = UIWindow()
            
            if let id = UserDefaults.standard.string(forKey: "userId"), !id.isEmpty {
                
                let role = UserDefaults.standard.bool(forKey: "role")
                
                if role {
                    window?.rootViewController = UniteViewController()
                }else {
                    
                    let enObj = GlobalViewModel()
                    let enFamObj = FamilyViewModel()
                    
                   // let childCardsView = ChildCardsView()
                    let childCardsView = ChildCardsView()
                        .environmentObject(enObj)
                        .environmentObject(enFamObj)
                    
                    let hostingController = UIHostingController(rootView: childCardsView)
                    window?.rootViewController = hostingController
                }
                
            }else {
                let hostingController = UIHostingController(rootView: LoginView())
                window?.rootViewController = hostingController
            }
           window?.makeKeyAndVisible()
        }
        
        return true
    }

    

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "PaymeFeature")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

