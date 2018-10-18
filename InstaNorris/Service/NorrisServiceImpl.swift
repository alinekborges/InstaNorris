//
//  NorrisServiceImpl.swift
//  InstaNorris
//
//  Created by Aline Borges on 30/04/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class NorrisServiceImpl: NorrisService {
    
    let provider: MoyaProvider<NorrisRouter>
    
    init(provider: MoyaProvider<NorrisRouter>) {
        self.provider = provider
    }
    
    func categories() -> Single<Response> {
        return self.provider.rx.request(.categories)
    }
    
    func search(_ query: String) -> Single<Response> {
        return self.provider.rx.request(.search(query))
    }
}
