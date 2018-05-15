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

protocol SearchDelegate: class {
    func searchCategory(_ category: String)
    func dismiss()
}

class SearchView: UIViewController {
    
    @IBOutlet weak var cloudTagView: CloudTagView!
    
    var viewModel: SearchViewModel!
    let norrisRepository: NorrisRepository
    
    weak var delegate: SearchDelegate?

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
        //self.cloudTagView.removeOnDismiss = false
        self.cloudTagView.delegate = self
    }
    
    func setupBindings() {
        self.viewModel.categories
            .drive(onNext: { [weak self] categories in
                for category in categories {
                    let tagView = TagView(text: category)
                    //tagView.iconImage = nil
                    self?.cloudTagView.tags.append(tagView)
                }
            }).disposed(by: rx.disposeBag)
    }
}

extension SearchView: TagViewDelegate {
    func tagTouched(_ tag: TagView) {
        self.delegate?.searchCategory(tag.text)
    }
}
