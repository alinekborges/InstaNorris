//
//  NorrisRepository.swift
//  InstaNorris
//
//  Created by Aline Borges on 30/04/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import RxSwift
import Moya

protocol NorrisRepository: class {
    func categories() -> Single<[String]>
    func search(_ query: String) -> Single<[Fact]>
}

struct NorrisError: LocalizedError {
    let message: String
    
    init(message: String = "Error! \n\n If this app was written by Chuck Norris, this would never happen") {
        self.message = message
    }
    
    var errorDescription: String? {
        return self.message
    }
}
