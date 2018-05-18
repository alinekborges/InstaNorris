//
//  CloudTagView+Rx.swift
//  InstaNorris
//
//  Created by Aline Borges on 17/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: CloudTagView {
    
    var items: Binder<[String]> {
        return Binder(self.base) { tagView, items in
            tagView.items = items
        }
    }
    
}
