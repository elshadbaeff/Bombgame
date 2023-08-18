//
//  CategoryCollectionView.swift
//  BombGame
//
//  Created by Марина on 08.08.2023.
//

import UIKit

class CategoryCollectionView: UICollectionView {

  let images = [#imageLiteral(resourceName: "new2"), #imageLiteral(resourceName: "image 3"), #imageLiteral(resourceName: "image 10"), #imageLiteral(resourceName: "image 4"), #imageLiteral(resourceName: "image 5"), #imageLiteral(resourceName: "image 6")]
  var names = DataManager.shared.categories.map { $0.name}
  private let collectionLayout = UICollectionViewFlowLayout()
  private let idCategoryCell = "idCategoryVC"

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: .zero, collectionViewLayout: collectionLayout)
    
    configure()
    setupLayout()
    setDelegates()
    register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: idCategoryCell)
    selectDefaultCategory()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func selectDefaultCategory() {
    if DataManager.shared.arrSelectedCategories.isEmpty,
       let defaultCategoryIndex = DataManager.shared.categories.firstIndex(where: { $0.name == "О разном" }) {
      let indexPath = IndexPath(item: defaultCategoryIndex, section: 0)
      DataManager.shared.arrSelectedIndex.append(indexPath)
      DataManager.shared.arrSelectedCategories.append("О разном")
      UserDefaultsManager.shared.selectedCategories = DataManager.shared.arrSelectedCategories
    }
  }

  private func setupLayout() {
    collectionLayout.minimumInteritemSpacing = 3 //минимальный размер между объектами
  }

  private func configure() {
    backgroundColor = .clear
    allowsMultipleSelection = true

    self.translatesAutoresizingMaskIntoConstraints = false
  }

  private func setDelegates() {
    dataSource = self
    delegate = self
  }
}

//MARK: UICollectionViewDataSource

extension CategoryCollectionView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCategoryCell, for: indexPath) as? CategoryCollectionViewCell else {
      return UICollectionViewCell()
    }
    cell.categoryImage.image = images[indexPath.row]
    cell.nameCategoryLabel.text = names[indexPath.row]

    if DataManager.shared.arrSelectedIndex.contains(indexPath) {
      cell.selectImage.tintColor = .black
    } else {
      cell.selectImage.tintColor = .white
    }

    cell.layoutSubviews()
    return cell
  }
}

//MARK: - UICollectionViewDelegate
extension CategoryCollectionView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let strData = names[indexPath.item]

    if DataManager.shared.arrSelectedIndex.contains(indexPath) {
      DataManager.shared.arrSelectedIndex = DataManager.shared.arrSelectedIndex.filter { $0 != indexPath }
      DataManager.shared.arrSelectedCategories = DataManager.shared.arrSelectedCategories.filter { $0 != strData }
    } else {
      DataManager.shared.arrSelectedIndex.append(indexPath)
      DataManager.shared.arrSelectedCategories.append(strData)
    }

    if DataManager.shared.arrSelectedIndex.isEmpty {
      DataManager.shared.arrSelectedIndex.append(indexPath)
      DataManager.shared.arrSelectedCategories.append(strData)
    }
    
    UserDefaultsManager.shared.selectedCategories = DataManager.shared.arrSelectedCategories

    collectionView.reloadData()
  }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension CategoryCollectionView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 182, height: 178)
  }
}
