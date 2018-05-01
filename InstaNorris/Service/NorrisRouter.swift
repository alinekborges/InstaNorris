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
}

extension NorrisRouter: TargetType {
    var baseURL: URL {
        return URL(string: NetworkingConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .categories:
            return "/categories"
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
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .categories:
            return nil
        }
    }
    
    var task: Task {
        if let `parameters` = parameters {
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        } else {
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}

