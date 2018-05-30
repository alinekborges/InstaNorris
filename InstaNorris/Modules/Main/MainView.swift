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
import Swinject

protocol MainDelegate: class {
    func openAbout()
}

class MainView: UIViewController {
    
    var viewModel: MainViewModel!
    let norrisRepository: NorrisRepository
    let localStorage: LocalStorage

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var searchContainer: UIView!
    let searchView: SearchView
    var stateView: StateView!
    
    weak var delegate: MainDelegate?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(searchView: SearchView, repository: NorrisRepository, localStorage: LocalStorage) {
        self.norrisRepository = repository
        self.searchView = searchView
        self.localStorage = localStorage
        super.init(nibName: String(describing: MainView.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
        self.setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setupBindings()
    }
    
}

extension MainView {
    
    func setupViewModel() {
        self.viewModel = MainViewModel(
            input: (search: self.headerView.search,
                  categorySelected: self.searchView.categorySelected,
                  recentSearchSelected: self.searchView.recentSearchSelected),
            norrisRepository: self.norrisRepository,
                           localStorage: localStorage)
    }
    
    func configureViews() {
        self.tableView.contentInset.top = self.headerView.maxHeight - 20
        self.tableView.register(cellType: FactCell.self)
        self.tableView.backgroundColor = .clear
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.allowsSelection = false
        self.configureSearchView()
        self.configureStateView()
    }
    
    func setupBindings() {
    
        self.viewModel.results
            .drive(tableView.rx
                .items(cellIdentifier: "FactCell",
                       cellType: FactCell.self)) { [weak self] _, element, cell in
                        cell.bind(element)
                        cell.delegate = self
            }.disposed(by: rx.disposeBag)
        
        self.viewModel.isFactsShown
            .drive(onNext: { [weak self] shown in
                self?.animateTableView(shown: shown)
            }).disposed(by: rx.disposeBag)
        
        self.viewModel.searchQuery
            .bind(to: self.headerView.searchTextField.rx.text)
            .disposed(by: rx.disposeBag)
        
        self.viewModel.viewState
            .drive(self.stateView.rx.state)
            .disposed(by: rx.disposeBag)
        
        self.viewModel.isViewStateHidden
            .drive(self.stateView.rx.isHidden)
            .disposed(by: rx.disposeBag)
        
        self.headerView.infoButton.rx.tap.bind { [weak self] _ in
            self?.delegate?.openAbout()
        }.disposed(by: rx.disposeBag)
        
        self.tableView.rx.contentOffset
            .map { $0.y }
            .map { ($0 + self.headerView.maxHeight) / (self.headerView.minHeight + self.headerView.maxHeight) }
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: self.headerView.rx.fractionComplete)
            .disposed(by: rx.disposeBag)
        
        self.headerView.searchTextField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: {
                self.viewModel.isSearchShown.onNext(true)
            }).disposed(by: rx.disposeBag)
        
        self.viewModel.isSearchShown
            .subscribe(onNext: { [weak self] show in
                self?.searchContainer.isHidden = !show
                if show {
                    self?.headerView.collapse()
                    self?.searchView.showAnimated()
                } else {
                    self?.headerView.expand()
                    self?.view.endEditing(true)
                }
            })
            .disposed(by: rx.disposeBag)
    }
    
    func animateTableView(shown: Bool) {
        UIView.animate(withDuration: 0.2) {
            if shown {
                self.tableView.alpha = 1.0
            } else {
                self.tableView.alpha = 0.0
            }
            self.view.layoutIfNeeded()
        }
    }
    
    func configureSearchView() {
        self.searchContainer.addSubview(searchView.view)
        self.addChildViewController(self.searchView)
        self.searchView.view.prepareForConstraints()
        self.searchView.view.pinEdgesToSuperview()
    }
    
    func configureStateView() {
        self.stateView = StateView()
        self.stateView.isUserInteractionEnabled = false
        self.view.addSubview(stateView)
        stateView.prepareForConstraints()
        stateView.pinEdgesToSuperview()
    }
}

extension MainView: FactCellDelegate {
    func share(image: UIImage?) {
        let imageShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}
