//
//  MainViewController.swift
//  BombGame
//
//  Created by Александра Савчук on 07.08.2023.
//

import UIKit

class MainViewController: UIViewController {

  private let collectionView = CategoryCollectionView()

  private lazy var gradientView: GradientView = {
    let gradientView = GradientView(frame: view.bounds)
    gradientView.translatesAutoresizingMaskIntoConstraints = false
    return gradientView
  }()

  private lazy var bombLabel: UILabel = {
    let label = UILabel()
    label.text = "БОМБА"
    label.textColor = .purpleLabel
    label.font = .boldSystemFont(ofSize: 70)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private lazy var bombImage: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.image = UIImage(named: "bomb")
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Игра для компании"
    label.textColor = .black
    label.font = .boldSystemFont(ofSize: 40)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  let startButton = CustomButton(customTitle: "Старт игры")
  let categoryButton = CustomButton(customTitle: "Категории")
  let rulesButton = CustomRoundButton(systemImageName: "questionmark")
  let settingsButton = CustomRoundButton(systemImageName: "gearshape")
  let continueButton = CustomButton(customTitle: "Продолжить")

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    subviews()
    setupConstraints()
  }

  private func subviews() {
    view.addSubview(gradientView)
    view.addSubview(startButton)
    view.addSubview(categoryButton)
    view.addSubview(bombLabel)
    view.addSubview(bombImage)
    view.addSubview(titleLabel)
    view.addSubview(rulesButton)
    view.addSubview(settingsButton)
    view.addSubview(continueButton)
  }

  func setupConstraints() {
    NSLayoutConstraint.activate([
      gradientView.topAnchor.constraint(equalTo: view.topAnchor),
      gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

      startButton.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -15),
      startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      startButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 2 / 3),
      startButton.heightAnchor.constraint(equalToConstant: 80),

      continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      continueButton.bottomAnchor.constraint(equalTo: categoryButton.topAnchor, constant: -15),
      continueButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 2 / 3),
      continueButton.heightAnchor.constraint(equalToConstant: 80),

      categoryButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
      categoryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      categoryButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 2 / 3),
      categoryButton.heightAnchor.constraint(equalToConstant: 80),

      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),

      bombLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      bombLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),

      bombImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
      bombImage.topAnchor.constraint(equalTo: bombLabel.bottomAnchor, constant: 20),
      bombImage.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -20),
      bombImage.widthAnchor.constraint(equalToConstant: 250),
      bombImage.heightAnchor.constraint(equalToConstant: 250),

      rulesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      rulesButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),

      settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      settingsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
    ])
  }

  @objc func startButtonPressed() {
    let gameVC = GameViewController()
    self.navigationController?.pushViewController(gameVC, animated: true)
  }

  @objc func categoryButtonPressed() {
    let categoryVC = CategoryViewContoller()
    self.navigationController?.pushViewController(categoryVC, animated: true)
  }

  @objc func rulesButtonPressed() {
    let rulesVC = RulesViewController()
    self.navigationController?.pushViewController(rulesVC, animated: true)
  }

  @objc func settingsButtonPressed() {
    let settingsVC = SettingsViewController()
    navigationController?.pushViewController(settingsVC, animated: true)
  }

  @objc func continueButtonPressed() {
    let gameVC = GameViewController()
    if let savedQuestion = UserDefaults.standard.string(forKey: "currentQuestion") {
      gameVC.textLabel.text = savedQuestion
      gameVC.shouldUpdateQuestion = false
    }
    gameVC.setupGIFs()
    gameVC.playButtonPressed()
    navigationController?.pushViewController(gameVC, animated: true)
  }

  func setup() {
    startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
    categoryButton.addTarget(self, action: #selector(categoryButtonPressed), for: .touchUpInside)
    rulesButton.addTarget(self, action: #selector(rulesButtonPressed), for: .touchUpInside)
    settingsButton.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
    continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
  }
}
