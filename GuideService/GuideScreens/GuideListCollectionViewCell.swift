//
//  GuideListCollectionViewCell.swift
//  GuideService
//
//  Created by Roman Vronsky on 29/08/23.
//

import UIKit

protocol FavoriteDelegate {
    func favButtonDidTap(index: Int)
}

class GuideListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "guideCell" 
    
    private var index = 0
    
    var delegate: FavoriteDelegate?
    
    private lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageView: UIImageView = {
       let image = UIImageView()
        image.layer.borderWidth = 0.2
        image.layer.borderColor = UIColor.systemIndigo.cgColor
        image.layer.cornerRadius = 16
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapFavButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ model: Brands, index: Int) {
        nameLabel.text = model.title ?? ""
        imageView.getImage(from: model.thumbUrls?.first ?? "")
        self.index = index
        if model.isLike ?? false {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    
    private func setupView() {
        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = .systemIndigo.withAlphaComponent(0.5)
        contentView.addSubview(nameLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
        
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            imageView.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 30),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 0.6),
            
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            favoriteButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
        
        ])
    }
    
   @objc private func tapFavButton() {
       self.delegate?.favButtonDidTap(index: self.index)
    }
}
