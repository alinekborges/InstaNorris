//
//  FactItemViewModel.swift
//  InstaNorris
//
//  Created by Aline Borges on 03/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class FactItemViewModel {
    
    let fact: PublishSubject<Fact>
    
    let text: Driver<String>
    
    init() {
        self.fact = PublishSubject<Fact>()
        
        self.text = self.fact
            .map { $0.value }
            .asDriver(onErrorJustReturn: "")
    }
    
    func bind(_ fact: Fact) {
        self.fact.onNext(fact)
    }
    
}
