//
//  AppDelegate.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 12/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import UIKit
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private let container = DependencyManager.makeContainer()
    
    // MARK: Application Lifecycle
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupInitialView()
        setupStorage()
        
        return true
    }
    
}

// MARK: Private

private extension AppDelegate {
    
    func setupInitialView() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        window.makeKeyAndVisible()
        self.window = window
        
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: container)
        window.rootViewController = storyboard.instantiateInitialViewController()
    }
    
    func setupStorage() {
        guard let storage = container.resolve(AlbumStorageProtocol.self) else {
            fatalError("Storage is not found")
        }
        
        storage.load { result in
            if case .failure(let error) = result {
                fatalError("Storage can't be loaded. Error: \(error)")
            }
        }
    }
    
}
