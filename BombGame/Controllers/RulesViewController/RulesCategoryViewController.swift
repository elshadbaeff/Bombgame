//
//  TestViewController.swift
//  BombGame
//
//  Created by Kirill Taraturin on 09.08.2023.
//

import UIKit

class RulesCategoryViewController: UIViewController {

  // MARK: - UI Properties
  private lazy var gradientView: GradientView = {
    let gradientView = GradientView()
    gradientView.translatesAutoresizingMaskIntoConstraints = false
    return gradientView
  }()

  private lazy var categoryLabel: UILabel = {
    let label = createLabel(
      with: "Категории",
      font: UIFont.boldSystemFont(ofSize: 35),
      textColor: .purpleLabel
    )

    return label
  }()

  private lazy var descriptionOneLabel: UILabel = {
    let label = createLabel(
      with: "В игре доступно 6 категорий и более 90 вопросов.",
      font: UIFont.boldSystemFont(ofSize: 25),
      textColor: .greyLabel
    )

    return label
  }()

  private lazy var descriptionTwoLabel: UILabel = {
    let label = createLabel(
      with: "Можно выбрать сразу несколько категорий для игры.",
      font: UIFont.boldSystemFont(ofSize: 25),
      textColor: .greyLabel
    )

    return label
  }()

  private var mainCollectionView: UICollectionView!
  private var stackView = UIStackView()

  // MARK: - Private Properties
  let categories = CategoryRules.getGategories()

  // MARK: - Life Cycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.title = "Помощь"

    view.addSubview(gradientView)

    setupCollectionView()

    view.addSubview(stackView)

    setupStackView()
    setupConstraintsToGradient()
  }

  // MARK: - Private Methods
  private func setupCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    layout.itemSize = CGSize(width: 145, height: 145)
    layout.scrollDirection = .vertical

    mainCollectionView = UICollectionView(
      frame: view.bounds,
      collectionViewLayout: layout
    )
    mainCollectionView.register(
      CategoryViewCell.self,
      forCellWithReuseIdentifier: "categoryCell"
    )

    mainCollectionView.backgroundColor = .clear
    mainCollectionView.dataSource = self
  }

  private func setupConstraintsToGradient() {
    NSLayoutConstraint.activate([
      gradientView.topAnchor.constraint(equalTo: view.topAnchor),
      gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }

  private func setupStackView() {
    stackView.axis = .vertical
    stackView.spacing = 15
    stackView.alignment = .fill
    stackView.distribution = .fill

    stackView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor
      ),
      stackView.leadingAnchor.constraint(
        equalTo: view.leadingAnchor,
        constant: 16
      ),
      stackView.trailingAnchor.constraint(
        equalTo: view.trailingAnchor,
        constant: -16
      ),
      stackView.bottomAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.bottomAnchor
      )
    ])

    stackView.addArrangedSubview(categoryLabel)
    stackView.addArrangedSubview(descriptionOneLabel)
    stackView.addArrangedSubview(descriptionTwoLabel)
    stackView.addArrangedSubview(mainCollectionView)
  }

  private func createLabel(with text: String, font: UIFont, textColor: UIColor) -> UILabel {
    let label = UILabel()
    label.text = text
    label.font = font
    label.textColor = textColor
    label.textAlignment = .center
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.translatesAutoresizingMaskIntoConstraints = false

    return label
  }
}

// MARK: - UICollectionViewDataSource
extension RulesCategoryViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    categories.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "categoryCell", for: indexPath)
        as? CategoryViewCell
    else {
      return UICollectionViewCell()
    }

    let category = categories[indexPath.row]
    cell.setupViews(category)

    return cell
  }
}
