//
//  AppFactory.swift
//  GuideService
//
//  Created by Roman Vronsky on 29/08/23.
//

import UIKit

class AppFactory {
    
    
//    private let coreDataManager: CoreDataManagerProtocol
    private let networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }
    
    func makeModule(ofType moduleType: Module.ModuleType) -> Module {
        switch moduleType {
        case .guide:
            let viewModel = GuideViewModel(networkManager: networkManager)
            let view = UINavigationController(rootViewController: GuideListViewController(viewModel: viewModel))
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
        
        }
    }
}
