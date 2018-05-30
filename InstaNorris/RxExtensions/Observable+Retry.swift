//
//  Observable+Retry.swift
//  InstaNorris
//
//  Created by Aline Borges on 30/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt
import Moya

public extension Observable {

    public func retryWhenNeeded() -> Observable<Element> {
        return self
            .retry(
                //the origin request count as a count, so as we want to be retried two times, then it needs to be 3
                .exponentialDelayed(maxCount: 3, initial: 4.0, multiplier: 2), shouldRetry: {error in
                    guard let moyaError = error as? MoyaError else {
                        return false
                    }
                    if case let .underlying(error, _) = moyaError {
                        let error = (error as NSError)
                        //Connection error
                        if error.domain == NSURLErrorDomain {
                            print("✅Connection errror!")
                            return true
                        } else if 500...599 ~= error.code {
                            return true
                        }
                    }
                    return false
        })
    }
}
