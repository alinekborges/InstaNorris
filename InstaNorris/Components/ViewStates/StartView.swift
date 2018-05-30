//
//  StartView.swift
//  InstaNorris
//
//  Created by Aline Borges on 29/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import UIKit

class StartView: UIView, StateSubview {
    
    private var didSetupViews: Bool = false
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Chuck Norris can guess what you wanna search, but I can't. Please type any search above ☻"
        label.font = UIFont(name: "AmericanTypewriter", size: 22)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let arrow: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "▲"
        label.font = UIFont.systemFont(ofSize: 100)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupViews()
        self.accessibilityIdentifier = "start_view"
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
        self.addSubview(label)
        self.addSubview(arrow)
        self.label.prepareForConstraints()
        self.arrow.prepareForConstraints()
        self.label.pinLeft(32)
        self.label.pinRight(32)
        self.label.pinBottom(130)
        self.label.topAnchor.constraint(equalTo: self.arrow.bottomAnchor, constant: 36).isActive = true
        self.arrow.centerHorizontally()
    }
    
}

