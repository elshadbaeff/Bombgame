//
//  NavigationBar.swift
//  BombGame
//
//  Created by Александра Савчук on 08.08.2023.
//

import Foundation
import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is MainViewController {
            setNavigationBarHidden(true, animated: animated)
        } else {
            setNavigationBarHidden(false, animated: animated)
        }

        if !(viewController is MainViewController) {
            let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goBack))
            backButton.tintColor = .blackBackButton
            viewController.navigationItem.leftBarButtonItem = backButton
        }
    }

    @objc private func goBack() {
        self.popViewController(animated: true)
    }
}
