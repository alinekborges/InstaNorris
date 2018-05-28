//
//  RandomImage.swift
//  InstaNorris
//
//  Created by Aline Borges on 28/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import UIKit

class Random {
    
    static let imagesCount = 13
    
    static var image: UIImage? {
        let random = randomNumber(1...13)
        return UIImage(named: "img_\(random)")
    }
    
}
