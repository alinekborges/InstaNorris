//
//  ErrorView.swift
//  InstaNorris
//
//  Created by Aline Borges on 29/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class ErrorView: UIView, StateSubview {
    
    private var didSetupViews: Bool = false
    
    var errorMessage: String = "Error!" {
        didSet {
            self.label.text = errorMessage
        }
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Error!"
        label.font = UIFont(name: "AmericanTypewriter", size: 20)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupViews()
        self.accessibilityIdentifier = "error_view"
    }
    
    func show() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1.0
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0.0
        }
    }
    
    private func setupViews() {
        if !didSetupViews {
            self.didSetupViews = true
            self.setupConstraints()
        }
    }
    
    private func setupConstraints() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "error"))
        self.addSubview(imageView)
        self.addSubview(label)
        
        imageView.prepareForConstraints()
        imageView.alpha = 0.7
        imageView.constraintWidth(120.0)
        imageView.constraintHeight(120.0)
        imageView.centerHorizontally()
        imageView.centerVertically()
        
        label.prepareForConstraints()
        label.centerHorizontally()
        label.pinBottom(130)
    }
    
}
