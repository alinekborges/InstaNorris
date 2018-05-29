//
//  SearchViewModel.swift
//  InstaNorris
//
//  Created by Aline Borges on 03/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import RxSwift
import RxCocoa

class SearchViewModel {
    
    let recentSearch: Driver<[String]>
    let isRecentSearchHidden: Driver<Bool>
    
    let categories: Driver<[String]>
    let categoriesError: Observable<NorrisError>
    
    let disposeBag = DisposeBag()
    
    init(norrisRepository: NorrisRepository,
         localStorage: LocalStorage) {
        
        let categoriesResult = norrisRepository.categories()
        
        self.recentSearch = localStorage.lastSearch
            .asDriver(onErrorJustReturn: [])
        
        self.isRecentSearchHidden = self.recentSearch
            .map { $0.count == 0 }
            .startWith(true)
        
        self.categories = categoriesResult
            .asObservable()
            .filterSuccess()
            .map { categories in
                categories.randomSample(Constants.categoryCount)
            }
            .asDriver(onErrorJustReturn: [])
        
        self.categoriesError = categoriesResult
            .asObservable()
            .filterError()
    
    }
}
