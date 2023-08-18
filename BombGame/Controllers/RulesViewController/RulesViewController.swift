//
//  RulesViewController.swift
//  BombGame
//
//  Created by Александра Савчук on 07.08.2023.
//

import Foundation
import UIKit

class RulesViewController: UIPageViewController {
  
  // MARK: - Private Properties
  private var pages = [UIViewController]()
  private var сurrentPageIndex = 0
  
  // MARK: - Life Cycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Помощь"
    
    dataSource = self
    
    let viewController1 = GameRulesViewController()
    let viewController2 = RulesCategoryViewController()
    let viewController3 = RulesSettingsViewController()
    
    pages = [viewController1, viewController2, viewController3]
  }
  
  // MARK: - Init
  override init(transitionStyle style: UIPageViewController.TransitionStyle,
                navigationOrientation: UIPageViewController.NavigationOrientation,
                options: [UIPageViewController.OptionsKey : Any]? = nil) {
    
    super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
    view.backgroundColor = .systemOrange
    setViewControllers([pages[0]], direction: .forward, animated: true)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UIPageViewControllerDataSource
extension RulesViewController: UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let currentIndex = pages.firstIndex(of: viewController) else {
      return nil
    }
    
    let previousIndex = currentIndex - 1
    
    if previousIndex >= 0 {
      return pages[previousIndex]
    }
    
    return nil
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let currentIndex = pages.firstIndex(of: viewController) else {
      return nil
    }
    
    let nextIndex = currentIndex + 1
    
    if nextIndex < pages.count {
      return pages[nextIndex]
    }
    
    return nil
  }
  
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    pages.count
  }
  
  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    0
  }
}
