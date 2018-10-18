//
//  Random+Utils.swift
//  InstaNorris
//
//  Created by Aline Borges on 28/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation

//https://stackoverflow.com/questions/24132399/how-does-one-make-random-number-between-range-for-arc4random-uniform
public func randomNumber<T: SignedInteger>(_ range: ClosedRange<T> = 1...6) -> T {
    let length = Int64(range.upperBound - range.lowerBound + 1)
    let value = Int64(arc4random()) % length + Int64(range.lowerBound)
    return T(value)
}
