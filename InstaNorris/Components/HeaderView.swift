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
    
    let maxHeight: CGFloat = 160
    let minHeight: CGFloat = 72
    
    var heightConstraint: NSLayoutConstraint!
    
    var title: String = "" {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    var fractionComplete: CGFloat = 0.0 {
        didSet {
            self.animator?.fractionComplete = fractionComplete
        }
    }
    
    private var animator: UIViewPropertyAnimator?
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 30, height: self.maxHeight)
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "teste"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    let searchTextField: UITextField = {
       let textField = UITextField()
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        textField.layer.cornerRadius = 6.0
        textField.textColor = .white
        textField.tintColor = .white
        return textField
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "search"), for: .normal)
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupViews()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupViews()
    }
    
    private func setupViews() {
        self.backgroundColor = .slate
        self.setupConstraints()
        
        self.searchTextField.setPadding(14)
        
        self.setupAnimator()
    }
    
    private func setupAnimator() {
        
        self.animator = UIViewPropertyAnimator(duration: 0.4, curve: .easeIn, animations: {
            self.heightConstraint.constant = self.minHeight
            //self.searchTextField.alpha = 0
            self.titleLabel.alpha = 0
            self.searchButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.superview?.layoutIfNeeded()
            self.layoutIfNeeded()
        })
        
        self.animator?.scrubsLinearly = true
        
    }
    
    private func setupConstraints() {
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.searchTextField)
        self.addSubview(self.searchButton)
        
        self.titleLabel.prepareForConstraints()
        self.searchTextField.prepareForConstraints()
        self.searchButton.prepareForConstraints()
        
        self.titleLabel.pinLeft(30.0)
        self.titleLabel.centerVertically(6)
        
        self.searchTextField.pinLeft(30.0)
        self.searchTextField.pinRight(30.0)
        self.searchTextField.pinBottom(12.0)
        self.searchTextField.constraintHeight(32.0)
        
        self.searchButton.pinBottom(18.0)
        self.searchButton.pinRight(36.0)
        self.searchButton.constraintHeight(20.0)
        self.searchButton.constraintWidth(20.0)
        
        self.heightConstraint = self.constraintHeight(self.maxHeight)
        
        self.layoutIfNeeded()
        
    }
    
}
