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
    let searchError = PublishSubject<NorrisError>()
    let isSearchShown = PublishSubject<Bool>()
    
    let isFactsShown: Driver<Bool>
    let searchQuery: Driver<String>
    
    let disposeBag = DisposeBag()
    
    init(input:
            (search: Driver<String>,
            categorySelected: Driver<String>,
            recentSearchSelected: Driver<String>),
            norrisRepository: NorrisRepository,
            localStorage: LocalStorage) {
        
        self.searchQuery = Driver.merge(
            input.search,
            input.recentSearchSelected)
            .filter { !$0.isEmpty }
        
        self.isFactsShown = self.isSearchShown
            .map { !$0 }
            .asDriver(onErrorJustReturn: true)
        
        let viewStateSubject = PublishSubject<ViewState>()
        
        let defaultSearchResult = searchQuery
            .do(onNext: { search in
                //side effects
                self.isSearchShown.onNext(false)
                localStorage.addSearch(search)
            })
            .flatMap { search in
                norrisRepository.search(search)
                    .asDriver(onErrorJustReturn: NorrisResponse.error(error:
                        NorrisError(message: "default error message")))
            }
        
        let categorySearchResult = input.categorySelected
            .do(onNext: { search in
                //side effects
                self.isSearchShown.onNext(false)
                localStorage.addSearch(search)
            })
            .flatMap { search in
                norrisRepository.searchCategory(search)
                    .asDriver(onErrorJustReturn: NorrisResponse.error(error:
                        NorrisError(message: "default error message")))
        }
        
        let searchResult = Driver.merge(defaultSearchResult, categorySearchResult)
        
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
