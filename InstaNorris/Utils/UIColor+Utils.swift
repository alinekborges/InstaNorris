//
//  UIColor+Utils.swift
//  InstaNorris
//
//  Created by Aline Borges on 03/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import UIKit

extension UIColor {
    
    @nonobjc class var slate: UIColor {
        return UIColor(red: 77, green: 96, blue: 112)
    }
    
    @nonobjc class var acqua: UIColor {
        return UIColor(red: 80, green: 227, blue: 194)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(Double(red) / 255.0),
                  green: CGFloat(Double(green) / 255.0),
                  blue: CGFloat(Double(blue) / 255.0),
                  alpha: 1)
    }
    
}
