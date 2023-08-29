//
//  Extensions.swift
//  GuideService
//
//  Created by Roman Vronsky on 29/08/23.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(_ urlString: String?) {
        let url = URL(string: urlString ?? "")
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url)
    }
}
