//
//  BaseUITest.swift
//  InstaNorrisTests
//
//  Created by Aline Borges on 17/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import KIF
import Swinject

@testable import InstaNorris

class BaseUITest: KIFTestCase {
    
    let container = Container()
    var window: UIWindow!
    
    override func beforeEach() {
        
        UIView.setAnimationsEnabled(false)
        
        self.configureContainer(container: self.container)
        
        let mainView = self.defaultContainer.container.resolve(MainView.self)!
        
        self.window = UIApplication.shared.keyWindow!
        
        window.rootViewController = mainView
        
    }
    
    func configureContainer(container: Container) {
        fatalError("mockContainer must be override")
    }
    
}
