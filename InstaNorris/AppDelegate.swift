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
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        self.defaultContainer = DefaultContainer()
        
        let currentWindow = UIWindow(frame: UIScreen.main.bounds)
        self.window = currentWindow
        
        let mainView = self.defaultContainer.container.resolve(OnboardingView.self)!
        
        self.window?.rootViewController = mainView
        
        self.window?.makeKeyAndVisible()
        
        return true
    }

}
