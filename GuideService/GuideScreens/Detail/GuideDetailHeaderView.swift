//
//  GuideDetailHeaderView.swift
//  GuideService
//
//  Created by Roman Vronsky on 29/08/23.
//

import UIKit

class GuideDetailHeaderView: UIView {
    
    let nameLabel = CustomLabel(inform: "", size: 14, weight: .bold, color: .white)
    
    let viewsCountLabel = CustomLabel(inform: "", size: 10, weight: .light, color: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.layer.cornerRadius = 10
        self.backgroundColor = .systemIndigo.withAlphaComponent(0.4)
        self.addSubview(nameLabel)
        self.addSubview(viewsCountLabel)
        
        NSLayoutConstraint.activate([
        
            self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.viewsCountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            self.viewsCountLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.viewsCountLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 20),
        ])
    }
}
