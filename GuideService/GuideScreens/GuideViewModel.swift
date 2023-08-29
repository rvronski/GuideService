//
//  GuideViewModel.swift
//  GuideService
//
//  Created by Roman Vronsky on 29/08/23.
//

import UIKit

protocol GuideViewModelProtocol: ViewModelProtocol {
    func getBrands(completion: @escaping (([Brands]?, NetworkError?) -> Void))
    func openGuideDetail(brand: Brands, index: Int)
}

class GuideViewModel: GuideViewModelProtocol {
    
    private let networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }
    
    var coordinator: GuideCoordinator?
    
    func getBrands(completion: @escaping (([Brands]?, NetworkError?) -> Void)) {
        networkManager.getBrands { brands, error  in
            if let error = error {
                completion(nil,error)
            }
            completion(brands, nil)
        }
    }
    
    func openGuideDetail(brand: Brands, index: Int) {
        self.coordinator?.openGuideDetail(brand: brand, index: index)
    }
    
}

