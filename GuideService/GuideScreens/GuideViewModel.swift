//
//  GuideViewModel.swift
//  GuideService
//
//  Created by Roman Vronsky on 29/08/23.
//

protocol GuideViewModelProtocol: ViewModelProtocol {
    
}

class GuideViewModel: GuideViewModelProtocol {

//    private let coreDataManager: CoreDataManagerProtocol
    private let networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol) {
//        self.coreDataManager = coreDataManager
        self.networkManager = networkManager
    }
    weak var coordinator: Coordinatable!
    
}

