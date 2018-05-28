//
//  CloudTagView.swift
//  InstaNorrisTests
//
//  Created by Aline Borges on 17/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import Swinject
import RxSwift
import RxCocoa
import UIKit
import KIF
import Quick
import Nimble

@testable import InstaNorris

class CloudTagViewSpec: BaseUITest {
    
    var subject: CloudTagView!
    
    let disposeBag = DisposeBag()

    override func beforeEach() {
        super.beforeEach()
        
        //creates an empty view controller with just our subject view for testing
        let viewController = UIViewController()
        
        self.subject = CloudTagView()
        
        viewController.view.addSubview(subject)
        
        subject.prepareForConstraints()
        subject.pinEdgesToSuperview(50.0)
        
        viewController.view.layoutIfNeeded()
        
        self.window.rootViewController = viewController
        
    }
    
    override func configureContainer(container: Container) {
        defaultContainer.container.register(NorrisService.self) { _ in
            return MockNorrisService()
        }
    }
    
    func testIsShowing() {
        expectToSee("cloudTagView")
        
    }
    
    func testBasicState() {
        let items = ["test1", "test2", "test3"]
    
        self.subject.items = items
        
        expectToSee("test1")
        expectToSee("test2")
        expectToSee("test3")
        
    }
    
    func testTapOnTag() {
        
        let items = ["test1", "test2", "test3"]
        
        self.subject.items = items
        
        var selectedCategory = ""
        
        self.subject.rx.tagSelected.drive(onNext: {
            selectedCategory = $0
        }).disposed(by: self.disposeBag)
        
        tapOnView("test1")
        
        expect(selectedCategory).toEventually(equal("test1"), timeout: 3)
        
    }
    
}
