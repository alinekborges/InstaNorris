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
    let searchHidden = PublishSubject<Bool>()
    
    let disposeBag = DisposeBag()
    
    init(input:
            (search: Driver<String>,
            searchTap: Signal<Void>,
            categorySelected: Driver<String>),
         repositories:
            (repository: NorrisRepository,
            localStorage: LocalStorage)) {
    
        let defaultSearch = input.searchTap.withLatestFrom(input.search)
            .asDriver(onErrorJustReturn: "")
        
        let searchQuery = Driver.merge(
            defaultSearch,
            input.categorySelected)
        
//        let searchResult = searchQuery
//            .flatMapLatest { search in
//                return repositories.repository.search(search)
//                    .do(onSuccess: { _ in repositories.localStorage.addSearch(search) })
//                    .map { $0 }
//                    .asDriver(onErrorJustReturn: NorrisResponse.error(error:
//                        NorrisError(message: "default error message")))
//        }
        
        let searchResult = repositories.repository.search("teste")
            .asDriver(onErrorJustReturn: NorrisResponse.error(error:
                                        NorrisError(message: "default error message")))

        searchResult
            .drive(onNext: { [weak self] response in
                switch response {
                case .success(let facts):
                    self?.results.onNext(facts)
                    self?.searchHidden.onNext(true)
                case .error(let error):
                    self?.searchError.onNext(error)
                }
            }).disposed(by: disposeBag)
        
    }
}
