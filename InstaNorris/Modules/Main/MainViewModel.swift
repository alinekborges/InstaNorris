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
    
    let results = PublishSubject<[Fact]>()
    let searchError = PublishSubject<Error>()
    let searchShown = PublishSubject<Bool>()
    
    let disposeBag = DisposeBag()
    
    init(input:
            (search: Driver<String>,
            categorySelected: Driver<String>,
            recentSearchSelected: Driver<String>),
         repositories:
            (repository: NorrisRepository,
            localStorage: LocalStorage)) {
        
        let searchQuery = Driver.merge(
            input.search,
            input.categorySelected,
            input.recentSearchSelected)
            .filter { !$0.isEmpty }
        
        let searchResult = searchQuery
            .do(onNext: { search in
                self.searchShown.onNext(false)
                repositories.localStorage.addSearch(search)
            })
            .flatMap { search in
                repositories.repository.search(search)
                    .asDriver(onErrorJustReturn: NorrisResponse.error(error:
                        NorrisError(message: "default error message")))
            }
        
        searchResult
            .drive(onNext: { [weak self] response in
                switch response {
                case .success(let facts):
                    self?.results.onNext(facts)
                case .error(let error):
                    self?.searchError.onNext(error)
                }
            }).disposed(by: disposeBag)
        
    }
}
