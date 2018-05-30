//
//  AboutView.swift
//  InstaNorris
//
//  Created by Aline Borges on 29/05/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol AboutDelegate: class {
    func close()
    func reset()
}

class AboutView: UIViewController {
    
    weak var delegate: AboutDelegate?

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var githubButton: UIButton!
    @IBOutlet weak var clearCacheButton: UIButton!
    
    init() {
        super.init(nibName: String(describing: AboutView.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
    }
    
}

extension AboutView {
    
    func configureViews() {
        self.githubButton.rx.tap.bind {
            let url = URL(string: Constants.github)
            url?.openInDefaultBrowser()
        }.disposed(by: rx.disposeBag)
        
        self.clearCacheButton.rx.tap.bind { [weak self] _ in
            self?.delegate?.reset()
        }.disposed(by: rx.disposeBag)
        
        self.closeButton.rx.tap.bind { [weak self] _ in
            self?.delegate?.close()
        }.disposed(by: rx.disposeBag)
    }
}
