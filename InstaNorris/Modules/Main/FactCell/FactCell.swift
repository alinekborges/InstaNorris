//
//  FactView.swift
//  InstaNorris
//
//  Created by Aline Borges on 03/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import Reusable

class FactCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var factLabel: UILabel!
    
    func bind(_ fact: Fact) {
        self.factLabel.text = fact.value
    }
    
}
