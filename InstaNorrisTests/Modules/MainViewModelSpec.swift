//
//  MainViewModelSpec.swift
//  InstaNorrisTests
//
//  Created by Aline Borges on 28/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import Swinject
import RxSwift
import RxCocoa
import Quick
import Nimble

@testable import InstaNorris

class MainViewModelSpec: QuickSpec {
    
    override func spec() {
        var subject: MainViewModel!
        
        let searchSubject = PublishSubject<String>()
        let categorySubject = PublishSubject<String>()
        let recentSearchSubject = PublishSubject<String>()
        
        let search = searchSubject.asDriver(onErrorJustReturn: "")
        let category = categorySubject.asDriver(onErrorJustReturn: "")
        let recentSearch = recentSearchSubject.asDriver(onErrorJustReturn: "")
        
        describe("MainViewModel behavior") {
            
            context("Success search") {
                
                beforeEach {
                    let repository = MockNorrisRepository()
                    let storage = MockLocalStorage()
                    subject = MainViewModel(input:
                        (search: search,
                         categorySelected: category,
                         recentSearchSelected: recentSearch),
                                            norrisRepository: repository,
                                            localStorage: storage)
                }
                
                it("regular search") {
                    
                    var result: [Fact] = []
                    
                    subject.results.drive(onNext: {
                        result = $0
                    }).disposed(by: self.rx.disposeBag)
                    
                    searchSubject.onNext("Test")
                    
                    expect(result).toEventuallyNot(beEmpty(), timeout: 5)
                    
                }
                
                it("category search") {
                    
                    var result: [Fact] = []
                    
                    subject.results.drive(onNext: {
                        result = $0
                    }).disposed(by: self.rx.disposeBag)
                    
                    categorySubject.onNext("Test")
                    
                    expect(result).toEventuallyNot(beEmpty(), timeout: 5)
                    
                }
                
                it("recent search") {
                    
                    var result: [Fact] = []
                    
                    subject.results.drive(onNext: {
                        result = $0
                    }).disposed(by: self.rx.disposeBag)
                    
                    recentSearchSubject.onNext("Test")
                    
                    expect(result).toEventuallyNot(beEmpty(), timeout: 5)
                    
                }
                
                it("hide facts view after fetching") {
                    var result: Bool = false
                    
                    subject.isFactsShown.drive(onNext: {
                        result = $0
                    }).disposed(by: self.rx.disposeBag)
                    
                    searchSubject.onNext("Test")
                    
                    expect(result).toEventually(beTrue(), timeout: 5)
                }
                
            }
            
            context("search error") {
                
                beforeEach {
                    let repository = MockNorrisRepository(success: false)
                    let storage = MockLocalStorage()
                    subject = MainViewModel(input:
                        (search: search,
                         categorySelected: category,
                         recentSearchSelected: recentSearch),
                                            norrisRepository: repository,
                                            localStorage: storage)
                }
                
                it("error") {
                    var result: Error?
                    
                    subject.searchError.drive(onNext: {
                        result = $0
                    }).disposed(by: self.rx.disposeBag)
                    
                    searchSubject.onNext("Test")
                    
                    expect(result).toEventuallyNot(beNil(), timeout: 5)
                }
                
            }
            
        }
        
    }
    
}
