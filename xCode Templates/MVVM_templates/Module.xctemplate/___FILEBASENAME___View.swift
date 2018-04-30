//___FILEHEADER___

import UIKit
import RxSwift
import RxCocoa

/*
 Code for dependency injection:
    self.register(___VARIABLE_moduleName___View.self) { resolver in
        ___VARIABLE_moduleName___View()
    }
 */

protocol ___VARIABLE_moduleName___ViewDelegate: class {
    
}

class ___VARIABLE_moduleName___View: UIViewController {
    
    var viewModel: ___VARIABLE_moduleName___ViewModel!
    
    weak var delegate: ___VARIABLE_moduleName___ViewDelegate?

    init() {
        super.init(nibName: String(describing: ___VARIABLE_moduleName___View.self), bundle: nil)
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

extension ___VARIABLE_moduleName___View {
    
    func setupViewModel() {
        self.viewModel = ___VARIABLE_moduleName___ViewModel(
            input: (<#inputs#>)
        )
    }
    
    func configureViews() {
        
    }
    
    func setupBindings() {

    }
}
