//
//  NorrisRepositoryImpl.swift
//  InstaNorris
//
//  Created by Aline Borges on 30/04/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class NorrisRepositoryImpl: NorrisRepository {
    
    let service: NorrisService
    
    init(service: NorrisService) {
        self.service = service
    }
    
    func categories() -> Single<NorrisResponse<[String]>> {
        return self.service.categories()
            .map { response in
                if response.statusCode == 200 {
                    if let categories = try? response.map([String].self) {
                        return NorrisResponse.success(value: categories)
                    }
                }
                
                return NorrisResponse.error(error: NorrisError(message: "error.categories"))
        }
        
    }
    
    func search(_ query: String) -> Single<NorrisResponse<[Fact]>> {
        return self.service.search(query)
            .map { response in
                if response.statusCode == 200 {
                    if let searchResponse = try? response.map(SearchResponse.self) {
                        return NorrisResponse.success(value: searchResponse.result)
                    }
                }
                return NorrisResponse.error(error: NorrisError(message: "error.facts"))
        }
    }
}
