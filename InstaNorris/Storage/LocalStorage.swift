//
//  LocalStorage.swift
//  InstaNorris
//
//  Created by Aline Borges on 22/05/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol LocalStorage: class {
    var lastSearch: Observable<[String]> { get }
    func addSearch(_ string: String)
    func clear()
}
