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
    
    let categories: Driver<[String]>
    let results: Observable<[Fact]>
    
    let search = PublishSubject<String>()
    
    init(search: Observable<String>, repository: NorrisRepository) {
        
        self.categories = repository.categories()
            .asDriver(onErrorJustReturn: [])
        
        self.results = self.search
            .flatMap {
                return repository.search($0)
                    .map { $0.result }
        }
    }
}
