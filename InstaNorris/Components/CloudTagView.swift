//
//  CloudTagView.swift
//  InstaNorris
//
//  Created by Aline Borges on 15/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import UIKit
import Reusable
import RxSwift
import RxCocoa

class CloudTagView: UIView {
    
    var items: [String] = ["teste", "teste1", "teste2"]
//    var items: Driver<[String]> = Driver.just(["teste", "teste1", "teste2"])
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return UICollectionView(frame: self.bounds, collectionViewLayout: layout)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupViews()
    }

    private func setupViews() {
        self.setupConstraints()
        self.collectionView.register(TagCell.self, forCellWithReuseIdentifier: "TagCell")
        self.setupBindinds()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func setupConstraints() {
        self.addSubview(self.collectionView)
        
        //self.collectionView.prepareForConstraints()
        //self.collectionView.pinEdgesToSuperview()
        //self.layoutIfNeeded()
        
    }
    
    private func setupBindinds() {
//        self.items.drive(collectionView.rx
//            .items(cellIdentifier: "TagCell",
//                   cellType: TagCell.self)) { _, element, cell in
//                    cell.titleLabel.text = element
//            }.disposed(by: rx.disposeBag)
    }
    
}

extension CloudTagView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath)
            as? TagCell else {
            fatalError("Cell not typed correctly")
        }
        cell.titleLabel.text = "OIE"
        cell.backgroundColor = .red
        return cell
    }
    
}

class TagCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupConstraints()
        self.backgroundColor = .red
    }
    
    func setupConstraints() {
        self.addSubview(titleLabel)
        //self.titleLabel.prepareForConstraints()
        //self.titleLabel.pinEdgesToSuperview()
    }
    
}
