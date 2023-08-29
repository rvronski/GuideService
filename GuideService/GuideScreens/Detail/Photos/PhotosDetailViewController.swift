//
//  PhotosDetailViewController.swift
//  GuideService
//
//  Created by Roman Vronsky on 29/08/23.
//

import UIKit

class PhotosDetailViewController: UIViewController {
    
    var indexPath: IndexPath
    var brand: Brands
    init(indexPath: IndexPath, brand: Brands) {
        self.indexPath = indexPath
        self.brand = brand
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifire)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dragInteractionEnabled = true
       
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
    }
   
    private func setupNavigationBar() {
        
        let leftButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(popVC))
        leftButton.tintColor = .systemIndigo
        navigationItem.leftBarButtonItem = leftButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.performBatchUpdates(nil) { _ in  self.collectionView.scrollToItem(at: self.indexPath, at: .right, animated: false)
        }
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(collectionView)

        NSLayoutConstraint.activate([
        
            self.collectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.collectionView.heightAnchor.constraint(equalTo: self.collectionView.widthAnchor),
        ])
    }
    
    
 @objc private func popVC() {
     
     self.navigationController?.dismiss(animated: true)
    }
}

extension PhotosDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            brand.thumbUrls?.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifire, for: indexPath) as! PhotosCollectionViewCell
            guard let images = brand.thumbUrls else { return UICollectionViewCell() }
            cell.setup(model: images[indexPath.row])
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let width = (collectionView.frame.width)
            let height = width * 0.7
            return CGSize(width: width, height: height)
        }

}
