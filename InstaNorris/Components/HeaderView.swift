//
//  HeaderView.swift
//  InstaNorris
//
//  Created by Aline Borges on 01/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import UIKit

class HeaderView: UIView {
    
    let maxHeight:CGFloat = 200
    let minHeight:CGFloat = 60
    
    var heightConstraint: NSLayoutConstraint!
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 30, height: self.maxHeight)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "teste"
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupViews()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupViews()
    }
    
    func setupViews() {
        self.backgroundColor = .red
        self.setupConstraints()
    }
    
    func setupConstraints() {
        
        self.addSubview(self.titleLabel)
        
        self.titleLabel.pinLeft(30.0)
        self.titleLabel.centerVertically()
    
        self.constraintHeight(self.maxHeight)
        
    }
    
}
