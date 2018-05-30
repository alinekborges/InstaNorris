//
//  RetrySpec.swift
//  InstaNorrisTests
//
//  Created by Aline Borges on 30/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt
import Quick
import Nimble
import Moya

@testable import InstaNorris

class RetrySpec: QuickSpec {
    
    let disposeBag = DisposeBag()
    
    override func spec() {
        
        describe("Testing retry behaviour") {
            
            it("Retries the right amount of times") {
                
                var errorCount = 0
                var count = 0
                
                let error = MoyaError.underlying(NSError(domain: NSURLErrorDomain, code: -1009, userInfo: nil), nil)
                
                let responses = [error, error, error]
                
                let observable = Observable.deferred { () -> Observable<Int> in
                    count += 1
                    print("count \(count)")
                    guard responses.count >= count else {
                        return .empty()
                    }
                    return .error(responses[count - 1])
                }
                
                observable
                    .retryWhenNeeded()
                    .subscribe(onNext: { _ in
                    }, onError: { _ in
                        errorCount += 1
                    }).disposed(by: self.disposeBag)
                
                expect(count).toEventually(be(2), timeout: 20)
                expect(errorCount).toEventually(be(1), timeout: 20)
                
            }
            
        }
        
    }
    
}
