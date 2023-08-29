//
//  GuideDetailViewController.swift
//  GuideService
//
//  Created by Roman Vronsky on 29/08/23.
//

import UIKit

class GuideDetailViewController: UIViewController {
    
    var brand: Brands
   
    var index: Int
    
    init(brand: Brands, index: Int) {
        self.brand = brand
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var cellItem = UICollectionViewCell()
    
    private lazy var headerView: GuideDetailHeaderView = {
       let view = GuideDetailHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapFavButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifire)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(headerView)
        self.view.addSubview(collectionView)
        headerView.addSubview(likeButton)
        headerView.nameLabel.text = brand.title ?? ""
        headerView.viewsCountLabel.text = "Просмотров - \(brand.viewsCount ?? 0)"
        changeLike()
        
        NSLayoutConstraint.activate([
        
            headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            headerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10),
            headerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10),
            
            self.likeButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 16),
            self.likeButton.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -16),
            
            self.collectionView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            
        ])
    }
    
    private func changeLike() {
        let likeImage = brand.isLike ?? false ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        likeButton.setImage(likeImage, for: .normal)
    }
    
    @objc private func tapFavButton() {
        let brand = brandsArray[index]
        if brand.isLike ?? false {
            brand.isLike = false
        } else {
            brand.isLike = true
        }
        self.brand = brand
        changeLike()
     }
}

extension GuideDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        brand.thumbUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifire, for: indexPath) as! PhotosCollectionViewCell
        guard let image = brand.thumbUrls else {return UICollectionViewCell()}
        cell.setup(model: image[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = (collectionView.frame.width - 50) / 4
        
        return CGSize(width: itemWidth, height: itemWidth)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let item = collectionView.cellForItem(at: indexPath) else {return}
        self.cellItem = item
        let presentViewController = PhotosDetailViewController(indexPath: indexPath, brand: brand)
        let navController =  UINavigationController(rootViewController: presentViewController)
         navController.transitioningDelegate = self
         navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
}

extension GuideDetailViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimator(presentationStartItem: self.cellItem, isPresenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimator(presentationStartItem: self.cellItem, isPresenting: false)
    }
}
