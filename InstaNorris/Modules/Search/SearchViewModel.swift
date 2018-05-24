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
    
    let categories = PublishSubject<[String]>()
    let categoriesError = PublishSubject<Error>()
    
    let disposeBag = DisposeBag()
    
    init(norrisRepository: NorrisRepository,
         localStorage: LocalStorage) {
        
        let categoriesResult = norrisRepository.categories()
            .asDriver(onErrorJustReturn: NorrisResponse.error(error: NorrisError(message: "default error message")))
        
        self.recentSearch = localStorage.lastSearch
            .asDriver(onErrorJustReturn: [])
        
        categoriesResult
            .drive(onNext: { [weak self] response in
                switch response {
                case .success(let categories): self?.categories.onNext(categories.randomSample(Constants.categoryCount))
                case .error(let error):
                    self?.categoriesError.onNext(error)
                }
            }).disposed(by: disposeBag)
        
    }
}
