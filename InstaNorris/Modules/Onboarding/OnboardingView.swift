//
//  OnboardingView.swift
//  InstaNorris
//
//  Created by Aline Borges on 29/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class OnboardingView: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var largeViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var largeViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var largeView: UIView!
    
    @IBOutlet var leadingConstraints: [NSLayoutConstraint]!
    @IBOutlet var bottomConstraints: [NSLayoutConstraint]!
    @IBOutlet var views: [UIView]!
    
    var animators: [UIViewPropertyAnimator] = []
    
    init() {
        super.init(nibName: String(describing: OnboardingView.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureViews()
    }
    
}

extension OnboardingView {
    
    func configureViews() {
        self.largeView.layer.cornerRadius = 70.0
        
        self.views.forEach { view in
            view.layer.cornerRadius = view.frame.width / 2
        }
        
        self.setupAnimators()
    }
    
    func setupAnimators() {
        let largeViewAnimator = UIViewPropertyAnimator(duration: 0.4, curve: .easeOut) {
            self.largeViewLeadingConstraint.constant = self.view.frame.width - 180
            self.largeViewBottomConstraint.constant = self.view.frame.height - 240
            self.largeView.layer.cornerRadius = 6.0
            self.view.layoutIfNeeded()
        }
        largeViewAnimator.scrubsLinearly = false
        
        addAnimator(itemPosition: 0,
                    bottomPosition: self.view.frame.height - 280,
                    leadingPosition: self.view.frame.width - 280,
                    controlPoint: CGPoint(x: 0.7, y: 0.3))
        
        addAnimator(itemPosition: 1,
                    bottomPosition: self.view.frame.height - 300,
                    leadingPosition: self.view.frame.width - 200,
                    controlPoint: CGPoint(x: 0.92, y: 0.4))
        
        addAnimator(itemPosition: 2,
                    bottomPosition: self.view.frame.height - 200,
                    leadingPosition: self.view.frame.width - 240,
                    controlPoint: CGPoint(x: 0.83, y: 0.2))
        
        self.animators.append(largeViewAnimator)
        
    }
    
    func addAnimator(itemPosition: Int, bottomPosition: CGFloat, leadingPosition: CGFloat, controlPoint: CGPoint) {
        let animator = UIViewPropertyAnimator(duration: 0.4, controlPoint1: controlPoint, controlPoint2: controlPoint) {
            self.bottomConstraints[itemPosition].constant = bottomPosition
            self.leadingConstraints[itemPosition].constant = leadingPosition
            self.views[itemPosition].layer.cornerRadius = 6.0
            self.view.layoutIfNeeded()
        }
        
        animator.scrubsLinearly = false
        self.animators.append(animator)
    }

}

extension OnboardingView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let percent = (scrollView.contentOffset.x / (scrollView.contentSize.width - self.view.frame.width))
        
        animators.forEach { $0.fractionComplete = percent }
    }
}
