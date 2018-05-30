//
//  MainFlowTests.swift
//  InstaNorrisTests
//
//  Created by Aline Borges on 30/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import KIF
import Swinject
import RxSwift

@testable import InstaNorris

/// Tests main user paths

class MainFlowTests: BaseUITest {
    
    let mockRepository = MockNorrisRepository()
    
    override func configureContainer(container: Container) {
        container.register(LocalStorage.self) { _ in
            return MockLocalStorage()
        }
        
        container.register(NorrisRepository.self) { _ in
            return self.mockRepository
        }
    }
    
    func testSeeStartViewOnOpening() {
        expectToSeeStartView()
    }
    
    func testSeeSearchView() {
        tapOnSearchView()
        expectToSeeSearchView()
    }
    
    func testSearchOnCategoryTap() {
        tapOnSearchView()
        tapOnCategory("category1")
        expectToSeeLoadingView()
        expectToSeeFactsList()
    }
    
    func testSearchOnRecentSearchTap() {
        tapOnSearchView()
        tapOnRecentSearch("search1")
        expectToSeeLoadingView()
        expectToSeeFactsList()
    }
    
    func testSearchOnButtonTap() {
        tapOnSearchView()
        fillSearch()
        tapOnSearchButton()
        expectToSeeLoadingView()
        expectToSeeFactsList()
    }
    
    func testSearchEmptyResults() {
        mockRepository.emptyResponse = true
        
        tapOnSearchView()
        fillSearch()
        tapOnSearchButton()
        expectToSeeLoadingView()
        expectToSeeEmptyView()
    }
    
    func testSecondSearchEmpty() {
        tapOnSearchView()
        fillSearch()
        tapOnSearchButton()
        expectToSeeLoadingView()
        expectToSeeFactsList()
        
        mockRepository.emptyResponse = true
        
        tapOnSearchView()
        fillSearch()
        tapOnSearchButton()
        expectToSeeEmptyView()
    }
    
    func testErrorResponse() {
        mockRepository.success = false
        
        tapOnSearchView()
        fillSearch()
        tapOnSearchButton()
        expectToSeeErrorView()
        
    }
    
    func testErrorWhenContentAvailable() {
        //normal search with results
        tapOnSearchView()
        fillSearch()
        tapOnSearchButton()
        expectToSeeFactsList()
        
        mockRepository.success = false
        
        tapOnSearchView()
        fillSearch()
        tapOnSearchButton()
        expectToSeeErrorToastView()
    }
}
