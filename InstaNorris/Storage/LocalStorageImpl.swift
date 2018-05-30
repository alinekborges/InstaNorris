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
    static let firstAccess = "first_access"

}

class LocalStorageImpl: LocalStorage {
    
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
        userDefaults.register(defaults: [LocalStorageKeys.firstAccess: true])
    }
    
    var lastSearch: Observable<[String]> {
        return userDefaults.rx
            .observe([String].self, LocalStorageKeys.lastSearch)
            .distinctUntilChanged()
            .unwrap()
    }
    
    var firstAccess: Bool {
        get {
            return userDefaults.bool(forKey: LocalStorageKeys.firstAccess)
        } set {
            userDefaults.set(newValue, forKey: LocalStorageKeys.firstAccess)
        }
    }
    
    func clear() {
        userDefaults.removeObject(forKey: LocalStorageKeys.lastSearch)
        userDefaults.removeObject(forKey: LocalStorageKeys.firstAccess)
    }
    
    func addSearch(_ string: String) {
        let current = userDefaults.array(forKey: LocalStorageKeys.lastSearch) as? [String] ?? []
        let newArray = self.addNewSearch(string.lowercased(), current: current)
        userDefaults.set(newArray, forKey: LocalStorageKeys.lastSearch)
    }
    
    func addNewSearch(_ string: String, current: [String]) -> [String] {
        var newArray = current
        
        //if there is a repeated element, remove old one
        if let index = newArray.index(of: string) {
            newArray.remove(at: index)
        }
        
        //if array is not full, always insert item at position 0
        if current.count < Constants.savedSearchCount {
            newArray.insert(string, at: 0)
            return newArray
        } else {
            //add new element at first position of array.remov
            newArray.removeLast()
            newArray.insert(string, at: 0)
            return newArray
        }
        
    }
    
}
