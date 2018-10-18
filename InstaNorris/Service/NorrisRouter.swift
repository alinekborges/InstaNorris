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
    case search(String)
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
            return arrayJsonSerializedUTF8(json: data)
        case .search:
            let data = ["total": 6,
                        "result": [["category": ["dev"],
                                    "icon_url": "www.testurl.com",
                                    "id": "id",
                                    "url": "www.testurl.com",
                                    "value": "Chuck Norris doesn't need testing. Aline is not that smart, so she needs some mock data"]
                ]] as [String: Any]
            return jsonSerializedUTF8(json: data)
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
