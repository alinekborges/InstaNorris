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
    
    var items: [String] = [] {
        didSet {
            self.observableItems.onNext(items)
        }
    }
    
    let observableItems = PublishSubject<[String]>()
    
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
        self.addSubview(self.collectionView)
        self.collectionView.register(TagCell.self, forCellWithReuseIdentifier: "TagCell")
        self.setupBindinds()
        self.collectionView.delegate = self
        self.backgroundColor = .clear
        self.collectionView.backgroundColor = .clear
    }
    
    private func setupBindinds() {
        
        observableItems
            .bind(to: collectionView.rx
            .items(cellIdentifier: "TagCell",
                   cellType: TagCell.self)) { _, element, cell in
                    cell.titleLabel.text = element
            }.disposed(by: rx.disposeBag)
        
    }
    
}

extension CloudTagView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = self.items[indexPath.row]
        let width = item.width(usingFont: TagCell.font) + 30
        print("width: \(width)")
        return CGSize(width: width, height: 26)
    }
    
}

class TagCell: UICollectionViewCell {
    
    static var font: UIFont = UIFont.systemFont(ofSize: 16)
    
    let titleLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupConstraints()
        self.titleLabel.font = TagCell.font
        self.backgroundColor = .slate
        self.titleLabel.textColor = .white
        self.titleLabel.textAlignment = .center
        self.layer.cornerRadius = 6.0
    }
    
    func setupConstraints() {
        self.addSubview(titleLabel)
        self.titleLabel.prepareForConstraints()
        self.titleLabel.pinTop()
        self.titleLabel.pinBottom()
        self.titleLabel.pinLeft(4)
        self.titleLabel.pinRight(4)
    }
    
}
