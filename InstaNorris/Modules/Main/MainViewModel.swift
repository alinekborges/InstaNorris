//
//  MainViewModel.swift
//  InstaNorris
//
//  Created by Aline Borges on 27/04/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import RxSwift
import RxCocoa

class MainViewModel {
    
    let repository: NorrisRepository
    
    let categories: Driver<[String]>
    let results: Driver<[Fact]>
    
    init(search: Observable<String>, repository: NorrisRepository) {
        self.repository = repository
        
        self.categories = self.repository.categories()
            .asDriver(onErrorJustReturn: [])
        
        self.results = self.repository.search("test")
            .map { $0.result }
            .asDriver(onErrorJustReturn: [])
    }
}
