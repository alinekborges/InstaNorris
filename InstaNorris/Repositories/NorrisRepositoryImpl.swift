//
//  NorrisRepositoryImpl.swift
//  InstaNorris
//
//  Created by Aline Borges on 30/04/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class NorrisRepositoryImpl: NorrisRepository {
    
    let service: NorrisService
    
    init(service: NorrisService) {
        self.service = service
    }
    
}
