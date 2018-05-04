//
//  SearchView.swift
//  InstaNorris
//
//  Created by Aline Borges on 03/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CloudTagView

class SearchView: UIViewController {
    
    @IBOutlet weak var cloudTagView: CloudTagView!
    
    var viewModel: SearchViewModel!
    let norrisRepository: NorrisRepository

    init(norrisRepository: NorrisRepository) {
        self.norrisRepository = norrisRepository
        super.init(nibName: String(describing: SearchView.self), bundle: nil)
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

extension SearchView {
    
    func setupViewModel() {
        self.viewModel = SearchViewModel(norrisRepository: self.norrisRepository)
    }
    
    func configureViews() {
        
    }
    
    func setupBindings() {
        self.viewModel.categories
            .drive(onNext: { [weak self] categories in
                for category in categories {
                    self?.cloudTagView.tags.append(TagView(text: category))
                }
            }).disposed(by: rx.disposeBag)
    }
}
