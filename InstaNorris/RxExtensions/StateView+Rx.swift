//
//  StateView+Rx.swift
//  InstaNorris
//
//  Created by Aline Borges on 29/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

extension Reactive where Base: StateView {
    
    var state: Binder<ViewState> {
        return Binder(self.base) { stateView, state in
            stateView.state = state
        }
    }
    
}
