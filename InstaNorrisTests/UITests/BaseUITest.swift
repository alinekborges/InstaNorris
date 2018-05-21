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
import UIKit

@testable import InstaNorris

class BaseUITest: KIFTestCase {
    
    let defaultContainer = DefaultContainer()
    var window: UIWindow!
    
    override func beforeEach() {
        
        UIView.setAnimationsEnabled(true)
        
        self.configureContainer(container: self.defaultContainer.container)
        
        self.window = UIApplication.shared.keyWindow!
        
    }
    
    func configureContainer(container: Container) {
        fatalError("mockContainer must be overritten")
    }
    
}
