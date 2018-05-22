//
//  LocalStorageImpl.swift
//  InstaNorris
//
//  Created by Aline Borges on 22/05/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift

struct LocalStorageKeys {
    private init() {}
    
    static let lastSearch = "last_search"

}

class LocalStorageImpl: LocalStorage {
    
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    var lastSearch: Observable<[String]> {
        get {
            return userDefaults.rx
                .observe([String].self, LocalStorageKeys.lastSearch)
                .distinctUntilChanged()
                .unwrap()
        }
    }
    
    func addSearch(_ string: String) {
        if let current = userDefaults.array(forKey: LocalStorageKeys.lastSearch) as? [String] {
            let newArray = self.addNewSearch(string, current: current)
            userDefaults.set(newArray, forKey: LocalStorageKeys.lastSearch)
        }
    }
    
    func addNewSearch(_ string: String, current: [String]) -> [String] {
        var newArray = current
        //if array is not full, always inser item at position 0
        if current.count < Constants.savedSearchCount - 1 {
            newArray.insert(string, at: 0)
            return newArray
        }
        
        //if there is a repeated element, remove old one
        if let index = newArray.index(of: string) {
            newArray.remove(at: index)
        }
        
        //add new element at first position of array
        newArray.insert(string, at: 0)
        return newArray
    }
    
}
