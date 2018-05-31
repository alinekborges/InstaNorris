//
//  Rx+Utils.swift
//  InstaNorris
//
//  Created by Aline Borges on 03/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import RxSwift
import RxCocoa

//https://stackoverflow.com/questions/36709503/rxswift-unwrap-optional-handy-function
extension Observable where Element: OptionalType {
    /// Returns an Observable where the nil values from the original Observable are
    /// skipped
    func unwrap() -> Observable<Element.Wrapped> {
        return self.filter { $0.asOptional != nil }.map { $0.asOptional! }
    }

}

/// Represent an optional value
///
/// This is needed to restrict our Observable extension to Observable that generate
/// .Next events with Optional payload
protocol OptionalType {
    associatedtype Wrapped
    var asOptional: Wrapped? { get }
}

/// Implementation of the OptionalType protocol by the Optional type
extension Optional: OptionalType {
    var asOptional: Wrapped? { return self }
}

extension ObservableType where E == String {
    func validateName(filterable: Bool = false) -> Observable<Bool> {
        var result = self.asObservable()
        
        if filterable {
            result = result.filter { $0.count > 0 }
        }
        
        return result.map { value in
            let split = value.split(separator: " ")
            
            if split.count <= 1 {
                return false
            }
            
            for value in 0 ..< split.count where split[value].count <= 1 {
                return false
            }
            
            return true
        }
}
}
