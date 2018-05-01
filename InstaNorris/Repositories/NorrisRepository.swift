//
//  NorrisRepository.swift
//  InstaNorris
//
//  Created by Aline Borges on 30/04/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import RxSwift
import Moya

protocol NorrisRepository: class {
    func categories() -> Single<[String]>
    func search(_ query: String) -> Single<SearchResponse>
}
