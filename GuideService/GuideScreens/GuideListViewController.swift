//
//  ViewController.swift
//  GuideService
//
//  Created by Roman Vronsky on 29/08/23.
//

import UIKit

class GuideListViewController: UIViewController {

    private let viewModel: GuideViewModelProtocol
    
    init(viewModel: GuideViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private var brands = [Brands]()
    
    private lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GuideListCollectionViewCell.self, forCellWithReuseIdentifier: GuideListCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loading(true)
        viewModel.getBrands { brands, error  in
            DispatchQueue.main.async {
                self.loading(false)
                if let error = error {
                    switch error {
                    case .noNetwork:
                        self.alertOk(title: "Что-то пошло не так", message: "Проверьте подключение к интернету")
                    case .invalidData:
                        self.alertOk(title: "Что-то пошло не так", message: "Похоже у нас проблемы. Повторите попытку позже")
                    }
                }
                guard let brands else {return}
                self.brands = brands
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setupView() {
        
        activityIndicator.color = .systemIndigo
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = .white
        self.view.addSubview(collectionView)
        self.view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
        
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    func loading(_ result: Bool) {
        if result {
            self.activityIndicator.startAnimating()
            self.activityIndicator.isHidden = false
        } else {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
}
extension GuideListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        brands.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GuideListCollectionViewCell.identifier, for: indexPath) as! GuideListCollectionViewCell
        let brand = self.brands[indexPath.row]
        cell.setup(brand, index: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width - 32
        let height = width * 0.8
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let brand = self.brands[indexPath.row]
        
        navigationController?.pushViewController(GuideDetailViewController(brand: brand), animated: true)
    }
}
extension GuideListViewController: FavoriteDelegate {
    
    func favButtonDidTap(index: Int) {
        let brand = self.brands.remove(at: index)
        if brand.isLike ?? false {
            brand.isLike = false
        } else {
            brand.isLike = true
        }
        self.brands.insert(brand, at: index)
        self.collectionView.reloadItems(at: [[0,index]])
    }
}

