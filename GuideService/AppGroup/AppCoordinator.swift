//
//  AppCoordinator.swift
//  GuideService
//
//  Created by Roman Vronsky on 29/08/23.
//

import UIKit

final class AppCoordinator: Coordinatable {
    
    private(set) var coordinators: [Coordinatable] = []
    private(set) var module: Module?
    private let factory: AppFactory
    init(factory: AppFactory) {
        self.factory = factory
    }

    func start() -> UIViewController {
        let guideCoordinator = GuideCoordinator(moduleType: .guide, factory: factory)
        let guideVC = guideCoordinator.start()
        addCoordinator(coordinator: guideCoordinator)
        return guideVC
    }
    
    func addCoordinator(coordinator: Coordinatable) {
        guard coordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        coordinators.append(coordinator)
    }
    
    func removeCoordinator() {
        coordinators.removeAll()
    }
    
}


