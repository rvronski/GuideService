//
//  GuideViewModel.swift
//  GuideService
//
//  Created by Roman Vronsky on 29/08/23.
//

protocol GuideViewModelProtocol: ViewModelProtocol {
    func getBrands(completion: @escaping (([Brands]?, NetworkError?) -> Void))
}

class GuideViewModel: GuideViewModelProtocol {

//    private let coreDataManager: CoreDataManagerProtocol
    private let networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol) {
//        self.coreDataManager = coreDataManager
        self.networkManager = networkManager
    }
    weak var coordinator: Coordinatable!
    
    func getBrands(completion: @escaping (([Brands]?, NetworkError?) -> Void)) {
        networkManager.getBrands { brands, error  in
            if let error = error {
                completion(nil,error)
            }
            completion(brands, nil)
        }
    }
}

