//
//  SearchResponse.swift
//  InstaNorris
//
//  Created by Aline Borges on 30/04/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation

struct SearchResponse: Codable {
    
    let total: Int
    let result: [Fact]
    
}
