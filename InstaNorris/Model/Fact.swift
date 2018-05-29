//
//  Fact.swift
//  InstaNorris
//
//  Created by Aline Borges on 01/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation

struct Fact: Decodable {
    let category: [String]
    let iconUrl: String
    let id: String
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case category
        case iconUrl = "icon_url"
        case id
        case value
    }
    
    init(category: [String] = [],
         iconUrl: String = "",
         id: String = "",
         value: String = "") {
        self.category = category
        self.iconUrl = iconUrl
        self.id = id
        self.value = value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        //TODO: test empty categories too
        if let categories = try container.decodeIfPresent([String].self, forKey: .category) {
            self.category = categories
        } else {
            self.category = ["unknown"]
        }
        
        self.iconUrl = try container.decode(String.self, forKey: .iconUrl)
        self.id = try container.decode(String.self, forKey: .id)
        self.value = try container.decode(String.self, forKey: .value)
        
    }
}
