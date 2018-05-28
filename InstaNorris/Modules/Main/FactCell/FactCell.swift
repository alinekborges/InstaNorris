//
//  FactView.swift
//  InstaNorris
//
//  Created by Aline Borges on 03/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import Reusable

protocol FactCellDelegate: class {
    func share(image: UIImage?)
}

class FactCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    
    var factFont: UIFont!
    
    weak var delegate: FactCellDelegate?
    
    var viewModel = FactItemViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupBindings()
        
        self.factFont = self.factLabel.font
    }
    
    func bind(_ fact: Fact) {
        self.viewModel.bind(fact)
    }
    
    func setupBindings() {
        self.viewModel.text
            .drive(factLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        self.viewModel.backgroundImage
            .drive(backgroundImage.rx.image)
            .disposed(by: rx.disposeBag)

        self.viewModel.fontSize
            .drive(factLabel.rx.fontSize)
            .disposed(by: rx.disposeBag)
        
        self.shareButton.rx.tap.bind { [weak self] in
            let image = self?.asImage()
            self?.delegate?.share(image: image)
        }.disposed(by: rx.disposeBag)
        
    }
}
