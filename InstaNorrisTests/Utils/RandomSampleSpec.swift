//
//  RandomSampleSpec.swift
//  InstaNorrisTests
//
//  Created by Aline Borges on 21/05/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import InstaNorris

class RandomSampleSpec: QuickSpec {
    
    override func spec() {
        
        let subject = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        describe("Test sample result from original array") {
            
            it("test result size") {
                let result = subject.randomSample(3)
                expect(result.count).to(be(3))
            }
            
            it("test if result is not the same as original array") {
                //I know there is a very small possibility that this test will fail because the random result could be identical to the original array, but I can't find a way to test it better
                let result = subject.randomSample(subject.count)
                
                var isIdentical: Bool = true
                for index in 0..<subject.count {
                    if result[index] != subject[index] {
                        isIdentical = false
                        assert(true)
                    }
                }
                
                if isIdentical {
                    assert(false)
                }
            }
        
        }
        
    }
    
}
