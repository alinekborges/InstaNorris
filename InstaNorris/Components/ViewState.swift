//
//  ViewState.swift
//  InstaNorris
//
//  Created by Aline Borges on 29/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import UIKit

enum ViewState {
    case loading
    case start
    case empty
    case error(error: NorrisError)
    case errorWithContent(error: NorrisError)
    case none
}

class StatesView: UIView {
    
    let testTitle = UILabel()
    
    var state: ViewState = .none {
        didSet {
            updateState(state)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupViews()
    }
    
    func updateState(_ state: ViewState) {
        print("update state: \(state)")
        switch state {
        case .loading:
            testTitle.text = "loading"
        case .start:
            testTitle.text = "start"
        case .empty:
            testTitle.text = "empty"
        case .error(let error):
            testTitle.text = error.localizedDescription
        case .errorWithContent(let error):
            testTitle.text = error.localizedDescription
        case .none:
            testTitle.text = "none"
        }
    }
    
    func setupViews() {
        self.setupConstraints()
        self.backgroundColor = .clear
    }
    
    func setupConstraints() {
        self.addSubview(testTitle)
        self.testTitle.prepareForConstraints()
        self.testTitle.centerHorizontally()
        self.testTitle.centerHorizontally()
    }
}
