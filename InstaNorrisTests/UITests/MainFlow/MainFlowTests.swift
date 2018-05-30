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

/// Tests mainly the happy path - no errors and checking visibility of views and user flows
class MainFlowTests: BaseUITest {
    
    override func configureContainer(container: Container) {
        container.register(LocalStorage.self) { _ in
            return MockLocalStorage()
        }
        
        container.register(NorrisRepository.self) { _ in
            return MockNorrisRepository()
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
    
}
