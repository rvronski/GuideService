//
//  GuideCoordinator.swift
//  GuideService
//
//  Created by Roman Vronsky on 29/08/23.
//

import UIKit

class GuideCoordinator: ModuleCoordinatable {
    
    var module: Module?
    private let factory: AppFactory
    private(set) var moduleType: Module.ModuleType
    private(set) var coordinators: [Coordinatable] = []
    
    init(moduleType: Module.ModuleType, factory: AppFactory) {
        self.moduleType = moduleType
        self.factory = factory
    }
    
    func start() -> UIViewController {
        let module = factory.makeModule(ofType: .guide)
        let viewController = module.view
        (module.viewModel as? GuideViewModel)?.coordinator = self
        self.module = module
        return viewController
    }
}

