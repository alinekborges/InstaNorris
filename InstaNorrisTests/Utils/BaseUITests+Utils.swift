//
//  BaseUITests+Utils.swift
//  InstaNorrisTests
//
//  Created by Aline Borges on 17/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import UIKit

@testable import InstaNorris

extension BaseUITest {
    
    func expectToSee(_ text: String) {
        tester().waitForView(withAccessibilityIdentifier: text)
    }
    
    func expectNotToSee(_ text: String) {
        tester().waitForAbsenceOfView(withAccessibilityIdentifier: text)
    }
    
    func tapOnView(_ accessibilityIdentifier: String) {
        tester().tapView(withAccessibilityIdentifier: accessibilityIdentifier)
    }

    func getView(_ text:String) -> UIView {
        return tester().waitForView(withAccessibilityLabel: text)
    }
}
