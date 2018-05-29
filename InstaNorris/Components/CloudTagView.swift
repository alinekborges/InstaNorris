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
    
    private let observableItems = PublishSubject<[String]>()
    
    private var tagHeight: CGFloat = 36
    
    private var tagBackgroundColor: UIColor = UIColor.white.withAlphaComponent(0.4)
    
    private var textColor: UIColor = .slate

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.translatesAutoresizingMaskIntoConstraints = false
        //self.setupViews()
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return UICollectionView(frame: self.bounds, collectionViewLayout: layout)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupViews()
    }
    
    func configure(tagHeight: CGFloat, tagBackgroundColor: UIColor, textColor: UIColor) {
        self.tagHeight = tagHeight
        self.tagBackgroundColor = tagBackgroundColor
        self.textColor = textColor
        self.collectionView.reloadData()
    }
    
    private func setupViews() {
        self.addSubview(self.collectionView)
        self.collectionView.register(TagCell.self, forCellWithReuseIdentifier: "TagCell")
        self.setupBindinds()
        self.collectionView.delegate = self
        collectionView.allowsSelection = true
        self.collectionView.prepareForConstraints()
        self.collectionView.pinEdgesToSuperview()
        self.backgroundColor = .clear
        self.collectionView.backgroundColor = .clear
        self.accessibilityIdentifier = "cloudTagView"
    }
    
    private func setupBindinds() {
        observableItems
            .asObservable()
            .bind(to: collectionView.rx
            .items(cellIdentifier: "TagCell",
                   cellType: TagCell.self)) { _, element, cell in
                    cell.bind(element, backgroundColor: self.tagBackgroundColor, textColor: self.textColor)
            }.disposed(by: rx.disposeBag)
    }
    
}

extension CloudTagView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = self.items[indexPath.row]
        let width = item.width(usingFont: TagCell.font) + 16
        return CGSize(width: width, height: self.tagHeight)
    }
    
}

class TagCell: UICollectionViewCell {
    
    static var font: UIFont = UIFont.boldSystemFont(ofSize: 16)
    
    let titleLabel = UILabel()
    
    var didSetupConstraints = false
    
    
    func bind(_ string: String, backgroundColor: UIColor, textColor: UIColor) {
        self.titleLabel.text = string
        self.accessibilityIdentifier = string
        self.titleLabel.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.font = TagCell.font
        self.titleLabel.textAlignment = .center
        self.layer.cornerRadius = 6.0
        self.setupConstraints()
        self.layoutIfNeeded()
    }
    
    func setupConstraints() {
        if !didSetupConstraints {
            didSetupConstraints = true
            self.addSubview(titleLabel)
            self.titleLabel.prepareForConstraints()
            self.titleLabel.pinTop()
            self.titleLabel.pinBottom()
            self.titleLabel.pinLeft(0)
            self.titleLabel.pinRight(0)
        }
    }
    
}
