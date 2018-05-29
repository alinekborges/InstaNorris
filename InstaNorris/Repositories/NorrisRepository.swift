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
    func categories() -> Single<NorrisResponse<[String]>>
    func search(_ query: String) -> Single<[Fact]>
}

enum NorrisResponse<T> {
    case success(value: T)
    case error(error: NorrisError)
}

struct NorrisError: LocalizedError {
    let message: String
    
    init(message: String = "norris.generic.error") {
        self.message = message
    }
    
    var errorDescription: String? {
        return self.message
    }
}
