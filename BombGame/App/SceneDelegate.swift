//
//  SceneDelegate.swift
//  BombGame
//
//  Created by Александра Савчук on 07.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    let rootViewController = MainViewController()
    let navigationController = CustomNavigationController(rootViewController: rootViewController)

    navigationController.navigationBar.isHidden = true
    navigationController.navigationBar.titleTextAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor.purpleColor,
      NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)
    ]
    
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
}
