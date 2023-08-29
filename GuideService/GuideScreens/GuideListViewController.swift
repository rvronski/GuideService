//
//  ViewController.swift
//  GuideService
//
//  Created by Roman Vronsky on 29/08/23.
//

import UIKit

class GuideListViewController: UIViewController {

    private let viewModel: GuideViewModelProtocol
    
    init(viewModel: GuideViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

