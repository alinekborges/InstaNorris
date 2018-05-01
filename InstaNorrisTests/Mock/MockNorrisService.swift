//
//  File.swift
//  InstaNorrisTests
//
//  Created by Aline Borges on 01/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import Moya
import RxSwift

@testable import InstaNorris

class MockNorrisService: NorrisService {
    
    let provider: MoyaProvider<NorrisRouter>

    init(provider: MoyaProvider<NorrisRouter> = MoyaProvider(stubClosure: MoyaProvider.immediatelyStub)) {
        self.provider = provider
    }
    
    func categories() -> Single<Response> {
        return self.provider.rx.request(.categories)
    }
    
    /*func search(_ query: String) -> Single<Response> {
        return self.provider.rx.request(.search(query: query))
    }*/
    
}
