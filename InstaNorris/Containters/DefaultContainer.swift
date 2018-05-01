//
//  DefaultContainer.swift
//  InstaNorris
//
//  Created by Aline Borges on 27/04/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import Swinject
import Moya

final class DefaultContainer {
    
    let container: Container
    
    init() {
        self.container = Container()
        self.registerServices()
        self.registerViews()
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

//Register Services
extension DefaultContainer {
    
    func registerServices() {
        
        self.container.register(NorrisService.self) { _ in
            let provider = MoyaProvider<NorrisRouter>(plugins: self.getDefaultPlugins())
            return NorrisServiceImpl(provider: provider)
        }
        
        self.container.register(NorrisRepository.self) { resolver in
            NorrisRepositoryImpl(
                service: resolver.resolve(NorrisService.self)!
            )
        }
    }
    
    func getDefaultPlugins() -> [PluginType] {
        #if DEBUG
            return [NetworkLoggerPlugin(verbose: true)]
        #else
            return []
        #endif
    }
    
}
