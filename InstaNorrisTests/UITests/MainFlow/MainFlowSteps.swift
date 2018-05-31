//
//  MainFlowSteps.swift
//  InstaNorrisTests
//
//  Created by Aline Borges on 30/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import Swinject
import RxSwift
import XCTest

@testable import InstaNorris

extension MainFlowTests {
    
    // MARK: - User actions
    
    func tapOnSearchView() {
        tapOnView("search_input")
    }
    
    func tapOnCategory(_ string: String) {
        tapOnView(string)
    }
    
    func tapOnRecentSearch(_ string: String) {
        tapOnView(string)
    }
    
    func tapOnSearchButton() {
        tapOnView("search_button")
    }
    
    func fillSearch() {
        insertText("Search", intoView: "search_input")
    }
    
    // MARK: - Views expected to be seen
    
    func expectToSeeStartView() {
        expectToSee("start_view")
    }
    
    func expectToSeeErrorView() {
        expectToSee("error_view")
    }
    
    func expectToSeeLoadingView() {
        expectToSee("loading_view")
    }
    
    func expectToSeeErrorToastView() {
        expectToSee("toast_view")
    }
    
    func expectToSeeEmptyView() {
        expectToSee("empty_view")
    }
    
    func expectToSeeSearchView() {
        expectToSee("search_view")
    }
    
    func expectToSeeFactsList() {
        expectToSee("facts_table_view")
    }
    
    // MARK: - Views expected to NOT be seen
    func expectNotToSeeSearchView() {
        expectNotToSee("search_view")
    }
    
    func expectNotToSeeFactsList() {
        expectNotToSee("facts_table_view")
    }
}
