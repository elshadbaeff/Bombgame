//
//  GameEndViewController.swift
//  BombGame
//
//  Created by Александра Савчук on 07.08.2023.
//

import Foundation
import UIKit

class GameEndViewController: UIViewController {
  
  // MARK: - UI properties
  private var mainStackView = UIStackView()
  
  private lazy var gradientView: GradientView = {
    let gradientView = GradientView()
    gradientView.translatesAutoresizingMaskIntoConstraints = false
    return gradientView
  }()
  
  private lazy var taskLabel: UILabel = {
    let label = createLabel(
      with: "Проигравший выполняет задание",
      textColor: .black,
      font: UIFont.boldSystemFont(ofSize: 25),
      lines: 2
    )
    return label
  }()
  
  private lazy var bombImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "bang")
    imageView.contentMode = .scaleAspectFit
    
    return imageView
  }()
  
  private lazy var descriptionTaskLabel: UILabel = {
    let label = createLabel(
      with: DataManager.shared.getRandomPunishment(),
      textColor: .purpleLabel,
      font: UIFont.boldSystemFont(ofSize: 20),
      lines: 0
    )
    
    return label
  }()
  
  private lazy var anotherTaskButton: CustomButton = {
    let taskButton = CustomButton(customTitle: "Другое Задание")
    taskButton.addTarget(self, action: #selector(changeQuestion), for: .touchUpInside)
    return taskButton
  }()
  
  private lazy var startOverButton: CustomButton = {
    let taskButton = CustomButton(customTitle: "Начать Заново")
    taskButton.addTarget(self, action: #selector(resetGame), for: .touchUpInside)
    return taskButton
  }()
  
  // MARK: - Private Properties
  private let punishment = DataManager.shared.punishments
  
  // MARK: - Life Cycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addSubviews()
    setupConstraints()
    createStackView()
    navigationItem.title = "Игра"
    if UserDefaultsManager.shared.taskSwitchState == false {
      descriptionTaskLabel.isHidden = true
      taskLabel.isHidden = true
    }
  }
  
  // MARK: - Actions
  @objc private func changeQuestion() {
    descriptionTaskLabel.text = DataManager.shared.getRandomPunishment()
  }
  
  @objc private func resetGame() {
    let mainVC = GameViewController()
    self.navigationController?.pushViewController(mainVC, animated: true)
  }
  
  // MARK: - Private Methods
  private func addSubviews() {
    view.addSubview(gradientView)
    view.addSubview(mainStackView)
  }
  
  private func setupConstraints() {
    
    NSLayoutConstraint.activate([
      gradientView.topAnchor.constraint(equalTo: view.topAnchor),
      gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      taskLabel.heightAnchor.constraint(equalToConstant: 80),
      descriptionTaskLabel.heightAnchor.constraint(equalToConstant: 100),
      anotherTaskButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 2 / 3),
      anotherTaskButton.heightAnchor.constraint(equalToConstant: 80),
      startOverButton.widthAnchor.constraint(
        equalToConstant: UIScreen.main.bounds.width * 2 / 3
      ),
      startOverButton.heightAnchor.constraint(equalToConstant: 80)
    ])
  }
  
  private func createStackView() {
    
    mainStackView.axis = .vertical
    mainStackView.spacing = 20
    mainStackView.alignment = .center
    mainStackView.distribution = .fill
    mainStackView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      mainStackView.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor
      ),
      mainStackView.leadingAnchor.constraint(
        equalTo: view.leadingAnchor,
        constant: 16
      ),
      mainStackView.trailingAnchor.constraint(
        equalTo: view.trailingAnchor,
        constant: -16
      ),
      mainStackView.bottomAnchor.constraint(
        equalTo: view.bottomAnchor, constant: -30
      ),
    ])
    
    mainStackView.addArrangedSubview(taskLabel)
    mainStackView.addArrangedSubview(bombImageView)
    mainStackView.addArrangedSubview(descriptionTaskLabel)
    mainStackView.addArrangedSubview(anotherTaskButton)
    mainStackView.addArrangedSubview(startOverButton)
  }
  
  private func createLabel(with text: String, textColor: UIColor, font: UIFont, lines: Int) -> UILabel {
    let label = UILabel()
    
    label.text = text
    label.textColor = textColor
    label.font = font
    label.numberOfLines = lines
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }
}
