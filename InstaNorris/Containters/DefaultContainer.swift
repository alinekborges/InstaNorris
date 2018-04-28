//
//  DefaultContainer.swift
//  InstaNorris
//
//  Created by Aline Borges on 27/04/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import Swinject

final class DefaultContainer {
    
    let container: Container
    
    init() {
        self.container = Container()
        self.registerServices()
        self.registerViews()
    }
    
}

//Register Services
extension DefaultContainer {
    
    func registerServices() {
        
    }
    
}

//Register Views
extension DefaultContainer {
    
    func registerViews() {
        self.container.register(MainView.self) { _ in
            MainView()
        }
    }
    
}
