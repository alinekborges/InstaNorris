//
//  SearchViewModel.swift
//  InstaNorris
//
//  Created by Aline Borges on 03/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import RxSwift
import RxCocoa
import RxSwiftExt
import RxSwiftUtilities

class SearchViewModel {
    
    let recentSearch: Driver<[String]>
    let isRecentSearchHidden: Driver<Bool>
    
    let categories: Driver<[String]>
    let categoriesError: Driver<Error>
    
    let isLoading: Driver<Bool>
    
    let disposeBag = DisposeBag()
    
    init(norrisRepository: NorrisRepository,
         localStorage: LocalStorage) {
        
        let loadingIndicator = ActivityIndicator()
        self.isLoading = loadingIndicator.asDriver()
        
        let categoriesResult = norrisRepository
            .categories()
            .trackActivity(loadingIndicator)
            .retryWhenNeeded()
            .materialize()
            .share()
        
        self.recentSearch = localStorage
            .lastSearch
            .asDriver(onErrorJustReturn: [])
        
        self.isRecentSearchHidden = self.recentSearch
            .map { $0.count == 0 }
            .startWith(true)
        
        self.categories = categoriesResult
            .elements()
            .asDriver(onErrorJustReturn: [])
        
        self.categoriesError = categoriesResult
            .errors()
            .asDriver(onErrorJustReturn: NorrisError())
    
    }
}
