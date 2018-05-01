//
//  MainView.swift
//  InstaNorris
//
//  Created by Aline Borges on 27/04/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainView: UIViewController {
    
    var viewModel: MainViewModel!
    let repository: NorrisRepository

    init(repository: NorrisRepository) {
        self.repository = repository
        super.init(nibName: String(describing: MainView.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
        self.setupViewModel()
        self.setupBindings()
    }
    
}

extension MainView {
    
    func setupViewModel() {
        self.viewModel = MainViewModel(repository: self.repository)
    }
    
    func configureViews() {
        
    }
    
    func setupBindings() {
        self.viewModel.results
            .drive(onNext: {
                print($0)
            })
    }
}
