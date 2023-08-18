//
//  CategoryViewController.swift
//  BombGame
//
//  Created by Александра Савчук on 07.08.2023.
//

import UIKit

class CategoryViewContoller: UIViewController {
  private lazy var gradientView: GradientView = {
    let gradientView = GradientView(frame: view.bounds)
    gradientView.translatesAutoresizingMaskIntoConstraints = false
    return gradientView
  }()
  
  private let collectionView = CategoryCollectionView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setSubviews()
    setConstraints()
  }
  
  private func setSubviews(){
    view.addSubview(gradientView)
    view.addSubview(collectionView)
    navigationItem.title = "Категории"
  }
}

extension CategoryViewContoller {
  public func setConstraints() {
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 70),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 5),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
    ])
  }
}
