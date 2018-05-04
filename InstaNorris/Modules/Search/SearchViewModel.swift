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
    
    let categories: Driver<[String]>
    
    init(norrisRepository: NorrisRepository) {
        
        self.categories = norrisRepository.categories()
            .asDriver(onErrorJustReturn: [])
        
    }
}
