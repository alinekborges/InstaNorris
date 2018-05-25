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
import RxGesture

protocol SearchDelegate: class {
    func searchCategory(_ category: String)
    func dismiss()
}

class SearchView: UIViewController {
    
    @IBOutlet weak var cloudTagView: CloudTagView!
    @IBOutlet weak var recentSearchTableView: UITableView!
    
    var viewModel: SearchViewModel!
    let norrisRepository: NorrisRepository
    let localStorage: LocalStorage
    
    weak var delegate: SearchDelegate?
    
    var categorySelected: Driver<String>!

    init(norrisRepository: NorrisRepository,
         localStorage: LocalStorage) {
        self.norrisRepository = norrisRepository
        self.localStorage = localStorage
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
        self.viewModel = SearchViewModel(
            norrisRepository: self.norrisRepository,
            localStorage: self.localStorage)
    }
    
    func configureViews() {
        self.recentSearchTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupBindings() {
        self.viewModel.categories
            .bind(to: self.cloudTagView.rx.items)
            .disposed(by: rx.disposeBag)
        
        self.categorySelected = self.cloudTagView.rx.tagSelected
        
//        self.categorySelected.drive(onNext: {
//            print("selected: \($0)")
//        })
        
        self.viewModel.recentSearch
            .drive(recentSearchTableView.rx.items(cellIdentifier: "cell",
                                                  cellType: UITableViewCell.self)) { _, element, cell in
                cell.textLabel?.text = element
            }.disposed(by: rx.disposeBag)
        
//        self.view.rx.tapGesture()
//            .when(.recognized)
//            .subscribe(onNext: { [weak self] _ in
//                self?.view.endEditing(true)
//            }).disposed(by: rx.disposeBag)
    }
}
