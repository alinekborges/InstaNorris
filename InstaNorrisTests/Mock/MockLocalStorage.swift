//
//  MockLocalStorage.swift
//  InstaNorrisTests
//
//  Created by Aline Borges on 27/05/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift

@testable import InstaNorris

class MockLocalStorage: LocalStorage {
    
    let isEmpty: Bool
    
    init(isEmpty: Bool = false) {
        self.isEmpty = isEmpty
    }
    
    var lastSearch: Observable<[String]> {
        if isEmpty {
            return PublishSubject<[String]>().asObservable()
        } else {
            return Observable.just(["search1", "search2"])
        }
    }
    
    func addSearch(_ string: String) {
        
    }
    
    func clear() {
        
    }
    
}
