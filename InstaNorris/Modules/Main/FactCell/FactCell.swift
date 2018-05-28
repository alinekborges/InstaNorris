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
    
    var viewModel = FactItemViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupBindings()
    }
    
    func bind(_ fact: Fact) {
        self.viewModel.bind(fact)
    }
    
    func setupBindings() {
        self.viewModel.text
            .drive(factLabel.rx.text)
            .disposed(by: rx.disposeBag)
    }
}
