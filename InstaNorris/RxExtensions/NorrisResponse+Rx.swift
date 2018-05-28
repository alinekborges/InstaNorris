//
//  NorrisResponse+Rx.swift
//  InstaNorris
//
//  Created by Aline Borges on 27/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType where E == NorrisResponse<[String]> {
    
    func filterSuccess() -> Observable<[String]> {
        return self.filter { result in
            if case .success = result {
                return true
            } else {
                return false
            }
        }.map { result in
            if case let .success(value) = result {
                return value
            } else {
                return []
            }
        }
    }
    
    func filterError() -> Observable<NorrisError> {
        return self.filter { result in
            if case .error = result {
                return true
            } else {
                return false
            }
            }.map { result in
                if case let .error(value) = result {
                    return value
                } else {
                    return NorrisError(message: "")
                }
        }
    }
    
}
