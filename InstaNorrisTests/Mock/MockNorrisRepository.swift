//
//  MockNorrisRepository.swift
//  InstaNorrisTests
//
//  Created by Aline Borges on 18/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift

@testable import InstaNorris

class MockNorrisRepository: NorrisRepository {

    let success: Bool
    let service: NorrisService

    let mockCategories = ["test1", "test2"]
    
    init(success: Bool = true, service: NorrisService = MockNorrisService()) {
        self.success = success
        self.service = service
    }

    func categories() -> Single<NorrisResponse<[String]>> {
        if success {
           return Single.just(NorrisResponse.success(value: self.mockCategories))
        } else {
            return Single.just(NorrisResponse.error(error: NorrisError(message: "mock api error")))
        }
    }

    func search(_ query: String) -> Single<NorrisResponse<[Fact]>> {
        if success {
            return self.service.search(query).map { response in
                if let searchResponse = try? response.map(SearchResponse.self) {
                    return NorrisResponse.success(value: searchResponse.result)
                }
                fatalError("This should not happen")
            }
        } else {
            return Single.just(NorrisResponse.error(error: NorrisError(message: "mock api error")))
        }
    }

}
