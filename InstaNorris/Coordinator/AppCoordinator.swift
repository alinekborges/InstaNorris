//
//  AppCoordinator.swift
//  InstaNorris
//
//  Created by Aline Borges on 29/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import UIKit
import Swinject

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    let container: Container
    let storage: LocalStorage
    
    var currentView: UIViewController? {
        get {
            return window.rootViewController
        }
        set {
            UIView.transition(with: self.window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.window.rootViewController = newValue
            }, completion: nil)
        }
    }
    
    init(window: UIWindow, container: Container) {
        self.window = window
        self.container = container
        self.storage = container.resolve(LocalStorage.self)!
    }
    
    func start() {
        showMainView()
    }
    
    fileprivate func showOnboarding() {
        let view = container.resolve(OnboardingView.self)!
        self.currentView = view
    }
    
    fileprivate func showMainView() {
        let view = container.resolve(MainView.self)!
        self.currentView = view
    }
}
