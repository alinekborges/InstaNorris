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

    var success: Bool = true
    let service: NorrisService

    let mockCategories = ["category1", "category2"]
    
    var emptyResponse: Bool = false
    
    init(success: Bool = true, service: NorrisService = MockNorrisService()) {
        self.success = success
        self.service = service
    }

    func categories() -> Single<[String]> {
        if success {
            if emptyResponse {
                return Observable.just([])
                    .delaySubscription(1, scheduler: MainScheduler.instance)
                    .asSingle()
            } else {
                return Observable.just(mockCategories)
                    .delaySubscription(1, scheduler: MainScheduler.instance)
                    .asSingle()
            }
        } else {
            let subject = PublishSubject<[String]>()
            subject.onError(NorrisError())
            return subject.asSingle()
        }
    }

    func search(_ query: String) -> Single<[Fact]> {
        if success {
            if emptyResponse {
                return Observable.just([])
                    .delaySubscription(1, scheduler: MainScheduler.instance)
                    .asSingle()
            } else {
                return self.service.search(query)
                    .map(SearchResponse.self)
                    .map { $0.result }
                    .delaySubscription(1, scheduler: MainScheduler.instance)
            }
        } else {
            let subject = PublishSubject<[Fact]>()
            subject.onError(NorrisError())
            return subject.asSingle()
        }
    }

}
