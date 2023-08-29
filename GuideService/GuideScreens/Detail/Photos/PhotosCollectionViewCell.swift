//
//  PhotosCollectionViewCell.swift
//  GuideService
//
//  Created by Roman Vronsky on 29/08/23.
//

import UIKit
import Kingfisher

class PhotosCollectionViewCell: UICollectionViewCell {

    static let identifire = "PhotosCell"
    
    
    private lazy var imageView = UIImageView()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(model: String) {
        self.imageView.setImage(model)
    }
    
    private func setupView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        self.contentView.layer.cornerRadius = 10
        self.contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.imageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        
        ])
    }
}
