//
//  AppDelegate.swift
//  InstaNorris
//
//  Created by Aline Borges on 26/04/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var defaultContainer: DefaultContainer!
    var appCoordinator: AppCoordinator!
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        self.defaultContainer = DefaultContainer()
        
        let currentWindow = UIWindow(frame: UIScreen.main.bounds)
        self.appCoordinator = AppCoordinator(window: currentWindow, container: defaultContainer.container)
        self.appCoordinator?.start()
        self.window = currentWindow
        self.window?.makeKeyAndVisible()
        
        return true
    }

}
