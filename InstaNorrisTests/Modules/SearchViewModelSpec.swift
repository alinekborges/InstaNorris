//
//  SearchViewModelSpec.swift
//  InstaNorrisTests
//
//  Created by Aline Borges on 25/05/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import Swinject
import RxSwift
import RxCocoa
import Quick
import Nimble

@testable import InstaNorris

class SearchViewModelSpec: QuickSpec {
    
    override func spec() {
        var subject: SearchViewModel!
        
        describe("SearchViewModel") {
            context("sucess") {
                
                beforeEach {
                    let repository = MockNorrisRepository()
                    let storage = MockLocalStorage()
                    
                    subject = SearchViewModel(norrisRepository: repository, localStorage: storage)
                }
                
                it("get categories with success") {
                    do {
                        let result = try subject.categories
                            .toBlocking(timeout: 1)
                            .first()
                        
                        expect(result).toNot(beEmpty())
                    } catch {
                        assert(false, error.localizedDescription)
                    }
                }
                
                it("recent search with success") {
                    do {
                        let result = try subject.recentSearch
                            .toBlocking(timeout: 1)
                            .first()
                        
                        expect(result).toNot(beEmpty())
                    } catch {
                        assert(false, error.localizedDescription)
                    }
                }
                
                it("showing recent search") {
                    
                    do {
                        let result = try subject.isRecentSearchHidden
                            .asObservable()
                            .skip(1)
                            .toBlocking(timeout: 2)
                            .first()
                        
                        expect(result).to(beFalse())
                    } catch {
                        assert(false, error.localizedDescription)
                    }
                }
            }
            
            describe("categories with error") {
                beforeEach {
                    let repository = MockNorrisRepository(success: false)
                    let storage = MockLocalStorage()
                    
                    subject = SearchViewModel(norrisRepository: repository, localStorage: storage)
                }
                
                it("error") {
                    do {
                        let result = try subject.categoriesError
                            .toBlocking(timeout: 2)
                            .first()
                        
                        expect(result).toNot(beNil())
                    } catch {
                        assert(false, error.localizedDescription)
                    }
                }
            }
            
            describe("empty recent search") {
                beforeEach {
                    let repository = MockNorrisRepository()
                    let storage = MockLocalStorage(isEmpty: true)
                    
                    subject = SearchViewModel(norrisRepository: repository, localStorage: storage)
                }
                
                it("hidden recent search") {
                    
                    do {
                        let isHidden = try subject.isRecentSearchHidden.asObservable().toBlocking(timeout: 1).first()
                        expect(isHidden).to(beTrue())
                    } catch {
                        assert(false, error.localizedDescription)
                    }
                }
            }
        }
        
    }
    
}
