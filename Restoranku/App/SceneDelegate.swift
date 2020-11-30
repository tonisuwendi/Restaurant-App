//
//  SceneDelegate.swift
//  Restoranku
//
//  Created by mac on 25/11/20.
//

import UIKit
import SwiftUI
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let homeUseCase = Injection.init().provideHome()
        
        let homePresenter = HomePresenter(homeUseCase: homeUseCase)
        
        let contentView = ContentView()
            .environmentObject(homePresenter)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "RestaurantApp")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() {
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
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        saveContext()
    }
    
}
