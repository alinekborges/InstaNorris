//
//  UILabel+Rx.swift
//  InstaNorris
//
//  Created by Aline Borges on 28/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UILabel {
    
    var fontSize: Binder<CGFloat> {
        return Binder(self.base) { label, size in
            let font = label.font.withSize(size)
            label.font = font
        }
    }
    
}
