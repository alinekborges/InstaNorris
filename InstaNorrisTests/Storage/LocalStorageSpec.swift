//
//  LocalStorageSpec.swift
//  InstaNorrisTests
//
//  Created by Aline Borges on 22/05/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import InstaNorris

class LocalStorageSpec: QuickSpec {
    
    override func spec() {
        
        let userDefaults = UserDefaults(suiteName: "InstaNorris.tests")!
        
        let subject: LocalStorage = LocalStorageImpl(userDefaults: userDefaults)
        
        describe("Test storage behavior") {
            
            beforeEach {
                subject.clear()
            }
            
            it("Old array is empty") {

                var newArray: [String] = []
                
                subject.lastSearch.subscribe(onNext: {
                    newArray = $0
                }).disposed(by: self.rx.disposeBag)
                
                subject.addSearch("test")
                
                expect(newArray.count).toEventually(be(1))
            }
            
            it("Old array is half full") {
                
                var newArray: [String] = []
                
                (0..<3).forEach {
                    subject.addSearch("test \($0)")
                }
                
                subject.lastSearch.subscribe(onNext: {
                    newArray = $0
                }).disposed(by: self.rx.disposeBag)
                
                subject.addSearch("test element")
                
                expect(newArray.count).toEventually(be(4))
                expect(newArray[0]).toEventually(match("test element"))
                
            }
            
            it("Old array is full") {
                
                var newArray: [String] = []

                (0..<8).forEach {
                    subject.addSearch("test \($0)")
                }
                
                subject.lastSearch.subscribe(onNext: {
                    newArray = $0
                }).disposed(by: self.rx.disposeBag)
                
                subject.addSearch("test element")
                
                expect(newArray.count).toEventually(be(Constants.savedSearchCount))
                expect(newArray[0]).toEventually(match("test element"))
                
            }
            
        }
        
    }
    
}
