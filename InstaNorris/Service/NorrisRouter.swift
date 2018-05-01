//
//  NorrisRouter.swift
//  InstaNorris
//
//  Created by Aline Borges on 30/04/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Moya

enum NorrisRouter {
    case categories
    case search(query: String)
}

extension NorrisRouter: TargetType {
    var baseURL: URL {
        return URL(string: NetworkingConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .categories:
            return "/categories"
        case .search:
            return "/search"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        switch self {
        case .categories:
            let data = ["category_test1", "category_test2", "category_test3"]
            return stringArrayToData(array: data)
        case .search(let query):
            return Data()
            //TODO: add sample data
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .categories:
            return nil
        case .search(let query):
            return ["query": query]
        }
    }
    
    var task: Task {
        if let `parameters` = parameters {
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        } else {
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}

