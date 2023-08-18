//
//  RulesSettingsViewController.swift
//  BombGame
//
//  Created by Kirill Taraturin on 11.08.2023.
//

import UIKit

class RulesSettingsViewController: UIViewController {

  // MARK: - UI Properties
  private lazy var gradientView: GradientView = {
    let gradientView = GradientView(frame: view.bounds)
    gradientView.translatesAutoresizingMaskIntoConstraints = false

    return gradientView
  }()

  private let mainTableView = UITableView()

  // MARK: - Private Properties
  private var settingsText = [
    "В настройках игры можно задать время взрыва бомбы:",
    "",
    "Если выбран режим “С Заданиями”, то после взрыва бомбы на экране будет появляться задание для проигравшего игрока.",
  ]

  private var settingsTextTwo = [
    "Включить / Отключить фоновую музыку.",
    "Выбрать звуки для фоновой музыки, тиканья бомбы и взрыва.",
    ""
  ]

  // MARK: - Life Cycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.isHidden = false
    navigationItem.title = "Помощь"

    view.addSubview(gradientView)
    view.addSubview(mainTableView)

    setupTableView()
    setupConstraints()
  }

  // MARK: - Private Methods
  private func setupTableView() {
    mainTableView.dataSource = self
    mainTableView.delegate = self

    mainTableView.register(SettingsCell.self, forCellReuseIdentifier: "settingsCell")
    mainTableView.register(BombTimeCell.self, forCellReuseIdentifier: "bombTimeCell")
    mainTableView.translatesAutoresizingMaskIntoConstraints = false

    mainTableView.sectionHeaderHeight = 60
    mainTableView.separatorStyle = .none

    mainTableView.showsVerticalScrollIndicator = false
    mainTableView.isScrollEnabled = false

    mainTableView.backgroundColor = .clear
  }

  private func setupConstraints() {

    // setup constraints to gradientView
    NSLayoutConstraint.activate([
      gradientView.topAnchor.constraint(equalTo: view.topAnchor),
      gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])

    // setup constraints to mainTableView
    NSLayoutConstraint.activate([
      mainTableView.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor
      ),
      mainTableView.leadingAnchor.constraint(
        equalTo: view.leadingAnchor,
        constant: 16
      ),
      mainTableView.trailingAnchor.constraint(
        equalTo: view.trailingAnchor,
        constant: -16
      ),
      mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

// MARK: - UITableViewDataSource
extension RulesSettingsViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    2
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 3
    } else {
      return 2
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let text = settingsText[indexPath.row]
    let textTwo = settingsTextTwo[indexPath.row]

    if indexPath.section == 0 && indexPath.row == 1 {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "bombTimeCell", for: indexPath) as? BombTimeCell else { return UITableViewCell() }

      cell.backgroundColor = .clear

      return cell
    } else if indexPath.section == 0 {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as? SettingsCell else { return UITableViewCell() }

      cell.backgroundColor = .clear
      cell.setupMainLabel(text)

      return cell
    } else {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as? SettingsCell else { return UITableViewCell() }

      cell.backgroundColor = .clear
      cell.setupMainLabel(textTwo)

      return cell
    }
  }
}

// MARK: - UITableViewDelegate
extension RulesSettingsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    60
  }

  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    guard let headerView = view as? UITableViewHeaderFooterView else { return }

    if let headerView = view as? UITableViewHeaderFooterView {
      headerView.contentView.backgroundColor = .clear

    }

    let label = UILabel()

    if section == 0 {
      label.text = "Настройки"
    } else {
      label.text = "Также в настройках можно"
    }

    label.textColor = #colorLiteral(red: 0.5838159919, green: 0.2887962759, blue: 0.7136611342, alpha: 1)
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 25)

    headerView.addSubview(label)

    label.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(
        equalTo: headerView.leadingAnchor,
        constant: 16
      ),
      label.trailingAnchor.constraint(
        equalTo: headerView.trailingAnchor,
        constant: -16
      ),
      label.topAnchor.constraint(
        equalTo: headerView.topAnchor,
        constant: 0
      ),
      label.bottomAnchor.constraint(
        equalTo: headerView.bottomAnchor,
        constant: 0)
    ])
  }

  func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
    return false
  }
}

