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
        
//        categoriesResult
//            .drive(onNext: { [weak self] response in
//                switch response {
//                case .success(let categories): self?.categories.onNext(categories.randomSample(Constants.categoryCount))
//                case .error(let error):
//                    self?.categoriesError.onNext(error)
//                }
//            }).disposed(by: disposeBag)
        
        //rself.categories =
        
        self.categories = categoriesResult
            .asObservable()
            .filterSuccess()
            .asDriver(onErrorJustReturn: [])
        
        self.categoriesError = categoriesResult
            .asObservable()
            .filterError()
        
        
        
    }
}
