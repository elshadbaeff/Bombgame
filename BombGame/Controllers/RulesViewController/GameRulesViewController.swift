//
//  GameRulesViewController.swift
//  BombGame
//
//  Created by Kirill Taraturin on 09.08.2023.
//

import UIKit

class GameRulesViewController: UIViewController {
  
  // MARK: - Private Properties
  private var mainTableView = UITableView()
  private let rules = Rule.getRules()
  
  private lazy var gradientView: GradientView = {
    let gradientView = GradientView(frame: view.bounds)
    gradientView.translatesAutoresizingMaskIntoConstraints = false
    
    return gradientView
  }()
  
  // MARK: - Life Cycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(gradientView)
    view.addSubview(mainTableView)
    
    navigationItem.title = "Помощь"
    
    setupTableView()
    setupConstraints()
  }
  
  // MARK: - Private Methods
  private func setupTableView() {
    mainTableView.sectionHeaderHeight = 60
    mainTableView.separatorStyle = .none
    
    mainTableView.register(
      CustomCell.self,
      forCellReuseIdentifier: "cell"
    )
    
    mainTableView.register(
      CustomButtonCell.self,
      forCellReuseIdentifier: "cellWithButton"
    )
    
    mainTableView.showsVerticalScrollIndicator = false
    mainTableView.isScrollEnabled = false
    
    mainTableView.delegate = self
    mainTableView.dataSource = self
    
    mainTableView.backgroundColor = .clear
    mainTableView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func setupConstraints() {
    
    // setup constraints to myTableView
    NSLayoutConstraint.activate([
      mainTableView.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor
      ),
      mainTableView.leadingAnchor.constraint(
        equalTo: view.leadingAnchor,
        constant: 10
      ),
      mainTableView.trailingAnchor.constraint(
        equalTo: view.trailingAnchor,
        constant: -10
      ),
      mainTableView.bottomAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.bottomAnchor
      )
    ])
    
    // setup constraints to gradientView
    NSLayoutConstraint.activate([
      gradientView.topAnchor.constraint(equalTo: view.topAnchor),
      gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
}

// MARK: - UITableViewDataSource
extension GameRulesViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    rules.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let number = rules[indexPath.row]
    
    if indexPath.row == 1 {
      guard
        let cell = tableView.dequeueReusableCell(
          withIdentifier: "cellWithButton",for: indexPath)
          as? CustomButtonCell
      else {
        return UITableViewCell()
      }
      
      cell.setupViews(number)
      cell.layoutIfNeeded()
      cell.backgroundColor = .clear
      
      return cell
    } else {
      guard
        let cell = tableView.dequeueReusableCell(
          withIdentifier: "cell", for: indexPath)
          as? CustomCell
      else {
        return UITableViewCell()
      }
      cell.setupViews(number)
      cell.layoutIfNeeded()
      cell.backgroundColor = .clear
      
      return cell
    }
  }
}

// MARK: - UITableViewDelegate
extension GameRulesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    60
  }
  
  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    guard let headerView = view as? UITableViewHeaderFooterView else { return }
    
    if let headerView = view as? UITableViewHeaderFooterView {
      headerView.contentView.backgroundColor = .clear
    }
    
    let label = UILabel()
    label.text = "Правила Игры"
    label.textColor = #colorLiteral(red: 0.5838159919, green: 0.2887962759, blue: 0.7136611342, alpha: 1)
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 35)
    
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
        equalTo: view.safeAreaLayoutGuide.topAnchor
      )
    ])
  }
  
  func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
    return false
  }
}
