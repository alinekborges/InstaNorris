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
import RxSwiftExt

class MainViewModel {
    
    let results: Driver<[Fact]>
    let searchError: Driver<Error>
    let isSearchShown: PublishSubject<Bool>
    
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
        
        let loadingIndicator = ActivityIndicator()
        self.isLoading = loadingIndicator.asDriver()

        //search
        self.searchQuery = Observable.merge(
            input.search.asObservable(),
            input.categorySelected.asObservable(),
            input.recentSearchSelected.asObservable())
            .filter { !$0.isEmpty }
        
        let isSearchShown = PublishSubject<Bool>()
        self.isSearchShown = isSearchShown
        
        let searchResult = searchQuery
            .do(onNext: { search in
                //side effects are hiding search view and adding this search recent search storage
                isSearchShown.onNext(false)
                localStorage.addSearch(search)
            })
            .flatMapLatest { search in
                norrisRepository.search(search)
                    .trackActivity(loadingIndicator)
                    .debug("search results")
                    .materialize() //converts error and onNext to events
            }.share()
        
        self.results = searchResult
            .elements()
            .startWith([])
            .asDriver(onErrorJustReturn: [])
        
        self.searchError = searchResult
            .errors()
            .asDriver(onErrorJustReturn: NorrisError())
        
        self.viewState = MainViewModel.viewState(results: results, error: searchError, isLoading: isLoading)
        
        let searchShownDriver = isSearchShown.asDriver(onErrorJustReturn: false)
        
        //weather state view is hidden of shown
        self.isViewStateHidden = Driver
            .combineLatest(self.results,
                           searchShownDriver,
                           self.isLoading) { results, searchShown, isLoading in
                if isLoading { return false }
                if searchShown { return true }
                if results.isEmpty { return false }
                return true
            }
            .asDriver(onErrorJustReturn: false)
        
        //the transparent background requires to hide the facts table when search is showing or when there is some state to be shown
        self.isFactsShown = Driver.combineLatest(
            self.isViewStateHidden,
            searchShownDriver) { viewStateHidden, searchShown in
                return viewStateHidden && !searchShown
            }
            .asDriver(onErrorJustReturn: false)
    }
    
    
    /// Returns Observable of ViewState, based on if there is any result, any errors or is loading
    ///
    /// - Parameters:
    ///   - results: Result of api jokes call
    ///   - error: Error thrown on api call
    ///   - isLoading: Wheater is loading or not
    /// - Returns: Observable already mapped to view state
    class func viewState(results: Driver<[Fact]>, error: Driver<Error>, isLoading: Driver<Bool>) -> Driver<ViewState> {
        //view states
        let isEmpty = results
            .filter { $0.isEmpty }
            .skip(1) //to avoid catching the "startWith"
            .map { _ in return ViewState.empty }
        
        let error = error
            .withLatestFrom(results) { error, results -> ViewState in
                if !results.isEmpty {
                    return ViewState.errorWithContent(error: error)
                } else {
                    return ViewState.error(error: error)
                }
        }
        
        let loading = isLoading
            .filter { $0 == true }
            .map { _ in return ViewState.loading }
        
        return Driver.merge(isEmpty,
                                 error,
                                 loading)
            .startWith(.start)
            .asDriver(onErrorJustReturn: ViewState.error(error: NorrisError()))

    }
}
