//
//  Array+Utils.swift
//  InstaNorris
//
//  Created by Aline Borges on 21/05/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation

extension Collection {
    
    //returns one random sample from collection
    var sample: Element? {
        guard !isEmpty else { return nil }
        
        let offset = Int(arc4random_uniform(UInt32(self.count)))
        let index = self.index(self.startIndex, offsetBy: offset)
        return self[index]
    }
    
    func randomSample(_ count: Int) -> [Element] {
        let sampleCount = Swift.min(count, self.count)
        
        var elements = Array(self)
        var result: [Element] = []
        
        while result.count < sampleCount {
            if let index = (0..<elements.count).sample {
                let element = elements.remove(at: index)
                result.append(element)
            }
        }
        
        return result
    }
}
