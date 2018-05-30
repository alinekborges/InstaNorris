//
//  NorrisService.swift
//  InstaNorris
//
//  Created by Aline Borges on 30/04/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import RxSwift
import Moya

protocol NorrisService {
    func categories()-> Single<Response>
    func search(_ query: String) -> Single<Response>
}
