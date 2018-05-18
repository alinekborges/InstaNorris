//
//  CloudTagView.swift
//  InstaNorrisTests
//
//  Created by Aline Borges on 17/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import Swinject
import RxSwift

@testable import InstaNorris

class CloudTagViewSpec: BaseUITest {
    
    var subject: CloudTagView!
    
    override func beforeEach() {
        super.beforeEach()
        
        //creates an empty view controller with just our subject view for testing
        let viewController = UIViewController()
        
        self.subject = CloudTagView()
        
        viewController.view.addSubview(subject)
        
        self.window.rootViewController = viewController
        
        subject.frame = viewController.view.frame
        subject.bounds = viewController.view.bounds
        
    }
    
    override func configureContainer(container: Container) {
        //nothing to do here
    }
    
}
