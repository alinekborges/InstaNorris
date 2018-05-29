//
//  LoadingView.swift
//  InstaNorris
//
//  Created by Aline Borges on 29/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class LoadingView: UIView, StateSubview {
    
    private var didSetupViews: Bool = false
    
    var lottieView: LOTAnimationView?
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Loading...  "
        label.font = UIFont(name: "AmericanTypewriter", size: 20)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupViews()
        self.accessibilityIdentifier = "loading_view"
    }
    
    func show() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1.0
        }
        lottieView?.play()
    }
    
    func hide() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0.0
        }
        lottieView?.stop()
    }
    
    private func setupViews() {
        if !didSetupViews {
            self.didSetupViews = true
            self.setupConstraints()
        }
    }
    
    private func setupConstraints() {
        self.lottieView = LOTAnimationView(name: "soda_loader")
        self.addSubview(lottieView!)
        self.addSubview(label)
        
        lottieView?.alpha = 0.8
        lottieView?.constraintWidth(120.0)
        lottieView?.constraintHeight(120.0)
        lottieView?.prepareForConstraints()
        lottieView?.centerHorizontally()
        lottieView?.centerVertically()
        lottieView?.loopAnimation = true
        
        label.prepareForConstraints()
        label.centerHorizontally()
        label.pinBottom(130)
    }
    
}
