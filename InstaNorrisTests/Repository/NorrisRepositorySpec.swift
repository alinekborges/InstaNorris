//
//  NorrisRepository.swift
//  InstaNorrisTests
//
//  Created by Aline Borges on 01/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import InstaNorris

class UserRepositorySpec: QuickSpec {

    override func spec() {
        
        var subject: UserRepository!
        
        describe("Test Sucess Repository") {
            
            beforeEach {
                subject = NorrisRepositoryImpl(service: MockNorrisService())
            }
            
            it("get categories with success") {
                do {
                    let result = try subject.categories().toBlocking().first()
                    expect(result).toNot(beNil())
                } catch let error {
                    fatalError(error.localizedDescription)
                }
            }
        }
        
    }
    
}
