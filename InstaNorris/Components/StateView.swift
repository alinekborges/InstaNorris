//
//  ViewState.swift
//  InstaNorris
//
//  Created by Aline Borges on 29/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import UIKit

protocol StateSubview {
    func show()
    func hide()
}

enum ViewState {
    case loading
    case start
    case empty
    case error(Error)
    case errorWithContent(Error)
    case none
}

class StateView: UIView {
    
    let testTitle = UILabel()
    
    private var didSetupViews: Bool = false
    
    let loadingView = LoadingView()
    let emptyView = EmptyView()
    let startView = StartView()
    let errorView = ErrorView()
    
    var allViews: [StateSubview] {
        return [loadingView, emptyView, startView, errorView]
    }
    
    var state: ViewState = .none {
        didSet {
            updateState(state)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupViews()
    }
    
    func updateState(_ state: ViewState) {
        print("🔴state: \(state)")
        allViews.forEach { $0.hide() }
        switch state {
        case .loading:
            loadingView.show()
        case .start:
            startView.show()
        case .empty:
            emptyView.show()
        case .error(let error):
            errorView.errorMessage = error.localizedDescription
            errorView.show()
        case .errorWithContent(let error):
            ToastView.show(error.localizedDescription)
        case .none:
            break
        }
    }
    
    private func setupViews() {
        if !didSetupViews {
            self.didSetupViews = true
            self.setupConstraints()
            self.testTitle.font = UIFont.systemFont(ofSize: 40)
        }
    }
    
    private func setupConstraints() {
        self.addSubview(testTitle)
        self.testTitle.prepareForConstraints()
        self.testTitle.pinBottom(50)
        self.testTitle.centerHorizontally()
        
        self.addSubview(self.loadingView)
        self.loadingView.prepareForConstraints()
        self.loadingView.pinEdgesToSuperview()
        
        self.addSubview(self.emptyView)
        self.emptyView.prepareForConstraints()
        self.emptyView.pinEdgesToSuperview()
        
        self.addSubview(self.startView)
        self.startView.prepareForConstraints()
        self.startView.pinEdgesToSuperview()
        
        self.addSubview(self.errorView)
        self.errorView.prepareForConstraints()
        self.errorView.pinEdgesToSuperview()
    }
}
