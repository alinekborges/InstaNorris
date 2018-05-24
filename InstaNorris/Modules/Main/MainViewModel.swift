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
    
    let disposeBag = DisposeBag()
    
    init(search: Driver<String>, searchTap: Signal<Void>, repository: NorrisRepository) {
        
        let searchResult = searchTap.debug().withLatestFrom(search)
            .flatMapLatest { search in
                return repository.search(search)
                    .map { $0 }
                    .asDriver(onErrorJustReturn: NorrisResponse.error(error: NorrisError(message: "default error message")))
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
