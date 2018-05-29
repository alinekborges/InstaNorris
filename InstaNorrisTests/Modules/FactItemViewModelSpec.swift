//
//  FactItemViewModelSpec.swift
//  InstaNorrisTests
//
//  Created by Aline Borges on 28/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxSwift
import RxCocoa

@testable import InstaNorris

class FactItemViewModelSpec: QuickSpec {
    
    override func spec() {
        
        let subject: FactItemViewModel = FactItemViewModel()
        
        describe("Item view model") {
            
            context("behavior") {
                
                it("fact with short text") {
                    var shortString = ""
                    
                    (0...78).forEach { _ in
                        shortString += "a"
                    }
                    
                    let fact = Fact(value: shortString)
                    
                    var result: CGFloat = 0
                    
                    subject.fontSize.drive(onNext: {
                        result = $0
                    }).disposed(by: self.rx.disposeBag)
                    
                    subject.bind(fact)
                    
                expect(result).toEventually(beCloseTo(Constants.largeFontSize))
                }
                
                it("fact with long text") {
                    var shortString = ""
                    
                    (0...80).forEach { _ in
                        shortString += "a"
                    }
                    
                    let fact = Fact(value: shortString)
                    
                    var result: CGFloat = 0
                    
                    subject.fontSize.drive(onNext: {
                        result = $0
                    }).disposed(by: self.rx.disposeBag)
                    
                    subject.bind(fact)
                    
                    expect(result).toEventually(beCloseTo(Constants.mediumFontSize))
                }
                
                it("fact text value") {
                    let value = "This is a test fact"
                    
                    let fact = Fact(value: value)
                    
                    var result = ""
                    
                    subject.text.drive(onNext: {
                        result = $0
                    }).disposed(by: self.rx.disposeBag)
                    
                    subject.bind(fact)
                    
                    expect(result).toEventually(match(value))
                    
                }
                
                it("category mapping") {
                    let fact = Fact(category: ["test"])
                    
                    var result: [String] = []
                    
                    subject.categories.drive(onNext: {
                        result = $0
                    }).disposed(by: self.rx.disposeBag)
                    
                    subject.bind(fact)
                    
                    expect(result.first).toEventually(match("#test"))
                }
                
            }
            
        }
        
    }
    
}
