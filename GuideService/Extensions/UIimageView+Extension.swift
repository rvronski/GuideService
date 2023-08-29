//
//  Extensions.swift
//  GuideService
//
//  Created by Roman Vronsky on 29/08/23.
//

import UIKit

extension UIImageView {
    
    func getImage(from: String) async {
        guard let url = URL(string: from) else { return }
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        indicator.startAnimating()
        indicator.isHidden = false
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) -> Void in
            guard let data = data , error == nil, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async { () -> Void in
                indicator.stopAnimating()
                indicator.isHidden = true
                self.image = image
            }
        }).resume()
    }
}
