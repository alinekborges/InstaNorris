//
//  MainViewModel.swift
//  InstaNorris
//
//  Created by Aline Borges on 27/04/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import RxSwift
import RxCocoa
import RxSwiftUtilities

class MainViewModel {
    
    let results = PublishSubject<[Fact]>()
    let searchError = PublishSubject<NorrisError>()
    let isSearchShown = PublishSubject<Bool>()
    
    let isFactsShown: Driver<Bool>
    let searchQuery: Observable<String>
    
    let viewState: Driver<ViewState>
    let isViewStateHidden: Driver<Bool>
    let isLoading: Driver<Bool>
    
    let disposeBag = DisposeBag()
    
    init(input:
            (search: Driver<String>,
            categorySelected: Driver<String>,
            recentSearchSelected: Driver<String>),
         norrisRepository: NorrisRepository,
         localStorage: LocalStorage) {
        
        self.isViewStateHidden = self.results
            .map { !$0.isEmpty }
            .asDriver(onErrorJustReturn: false)
        
        let loadingIndicator = ActivityIndicator()
        self.isLoading = loadingIndicator.asDriver()
        
        //view states
        let isEmpty = self.results
            .filter { $0.isEmpty }
            .map { _ in return ViewState.empty }
        
        let errorWithContent = Observable.combineLatest(self.searchError, results)
            .filter { _, results in return !results.isEmpty }
            .map { error, _ in ViewState.errorWithContent(error: error) }
        
        let error = Observable.combineLatest(self.searchError, results)
            .filter { _, results in return results.isEmpty }
            .map { error, _ in ViewState.error(error: error) }
        
        let loading = loadingIndicator
            .asObservable()
            .filter { $0 == true }
            .map { _ in return ViewState.loading }
        
        viewState = Observable.merge(isEmpty,
                                     errorWithContent,
                                     error,
                                     loading)
            .startWith(.start)
            .asDriver(onErrorJustReturn: ViewState.error(error: NorrisError()))
        
        //search
        self.searchQuery = Observable.merge(
            input.search.asObservable(),
            input.categorySelected.asObservable(),
            input.recentSearchSelected.asObservable())
            .filter { !$0.isEmpty }
        
        self.isFactsShown = self.isSearchShown
            .map { !$0 }
            .asDriver(onErrorJustReturn: true)
        
        let searchResult = searchQuery
            .do(onNext: { search in
                //side effects
                self.isSearchShown.onNext(false)
                localStorage.addSearch(search)
            })
            .flatMap { search in
                norrisRepository.search(search)
                    .trackActivity(loadingIndicator)
            }
        
        searchResult
            .subscribe(onNext: { [weak self] response in
                switch response {
                case .success(let facts):
                    self?.results.onNext(facts)
                case .error(let error):
                    self?.searchError.onNext(error)
                }
            }, onError: { error in
                    let norrisError = NorrisError(message: error.localizedDescription)
                    self.searchError.onNext(norrisError)
            }).disposed(by: disposeBag)
            
//            .subscribe(onNext: { [weak self] response in
//                switch response {
//                case .success(let facts):
//                    self?.results.onNext(facts)
//                    defaultState.onNext(.none)
//                case .error(let error):
//                    self?.searchError.onNext(error)
//                }
//            }).disposed(by: disposeBag)
        
    }
}
