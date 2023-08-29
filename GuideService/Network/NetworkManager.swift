//
//  NetworkManager.swift
//  GuideService
//
//  Created by Roman Vronsky on 29/08/23.
//

import Foundation

protocol NetworkProtocol: AnyObject {
    func getBrands(completion: ((_ brands: [Brands]?, NetworkError?) -> Void)?)
}

class NetworkManager: NetworkProtocol {
    
    func getBrands(completion: ((_ brands: [Brands]?, NetworkError?) -> Void)?) {
        guard let url = URL(string: "https://vmeste.wildberries.ru/api/guide-service/v1/getBrands" ) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error {
                print(error.localizedDescription)
                completion?(nil, NetworkError.noNetwork)
                return
            }
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            print("🍏 Statys Code = \(String(describing: statusCode))")
            if statusCode != 200 {
                print("Status Code = \(String(describing: statusCode))")
                completion?(nil, NetworkError.noNetwork)
                return
            }
            guard let data else {
                print("data = nil")
                completion?(nil, NetworkError.invalidData)
                return
            }
            do {
                let answer = try JSONDecoder().decode(AnswerBrands.self, from: data)
                let brands = answer.brands
                completion?(brands, nil)
            } catch {
                completion?(nil, NetworkError.invalidData)
                print(error)
            }
        }
        
        task.resume()
    }
}
