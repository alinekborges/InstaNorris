//
//  HeaderView+Rx.swift
//  InstaNorris
//
//  Created by Aline Borges on 03/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: HeaderView {
    
    var fractionComplete: Binder<CGFloat> {
        return Binder(self.base) { header, fractionComplete in
            header.fractionComplete = fractionComplete
        }
    }
    
    var searchTap: ControlEvent<Void> {
        return self.base.searchButton.rx.tap
    }
    
    var search: Observable<String> {
        return self.base.searchTextField.rx.text.asObservable().unwrap()
    }
    
}
