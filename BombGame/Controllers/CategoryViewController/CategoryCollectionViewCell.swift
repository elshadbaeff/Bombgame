//
//  CategoryCollectionViewCell.swift
//  BombGame
//
//  Created by Марина on 08.08.2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
  
  private let backView: UIView = {
    let view = UIView()
    view.backgroundColor = .purpleColor
    view.layer.cornerRadius = 50
    view.clipsToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
    
  }()
  
  let categoryImage: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.contentMode = .scaleAspectFill
    image.image?.withRenderingMode(.alwaysTemplate)
    return image
  }()
  
  let selectImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.tintColor = .white
    imageView.image = UIImage(systemName: "checkmark.circle.fill")
    return imageView
  }()
  
  let nameCategoryLabel: UILabel = {
    let label = UILabel()
    label.textColor = .yellowLabel
    label.font = .systemFont(ofSize: 21, weight: .heavy)
    label.numberOfLines = 0
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupViews()
    setConstaints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    addSubview(backView)
    backView.addSubview(categoryImage)
    backView.addSubview(nameCategoryLabel)
    backView.addSubview(selectImage)
  }
}

extension CategoryCollectionViewCell {
  
  private func setConstaints() {
    NSLayoutConstraint.activate([
      backView.leadingAnchor.constraint(equalTo: leadingAnchor),
      backView.trailingAnchor.constraint(equalTo: trailingAnchor),
      backView.bottomAnchor.constraint(equalTo: bottomAnchor),
      backView.topAnchor.constraint(equalTo: topAnchor),
      
      categoryImage.heightAnchor.constraint(equalToConstant: 100),
      categoryImage.widthAnchor.constraint(equalToConstant: 110),
      categoryImage.leadingAnchor.constraint(equalTo: selectImage.trailingAnchor),
      categoryImage.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
      
      nameCategoryLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
      nameCategoryLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
      nameCategoryLabel.topAnchor.constraint(equalTo: categoryImage.bottomAnchor, constant: 10),
      
      selectImage.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
      selectImage.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
      selectImage.heightAnchor.constraint(equalToConstant: 40),
      selectImage.widthAnchor.constraint(equalToConstant: 40)
      
    ])
  }
}
