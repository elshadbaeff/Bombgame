//
//  CustomButton.swift
//  BombGame
//
//  Created by Александра Савчук on 07.08.2023.
//

import UIKit

class CustomButton: UIButton {
    var customTitle: String? {
        didSet {
            setTitle(customTitle, for: .normal)
        }
    }

    init(customTitle: String) {
        super.init(frame: .zero)
        self.customTitle = customTitle
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

  private func setupButton() {
    self.layer.cornerRadius = 40
    self.backgroundColor = .purpleColor

    self.setTitleColor(.yellowLabel, for: .normal)
    self.setTitle(customTitle, for: .normal)
    self.titleLabel?.font = .boldSystemFont(ofSize: 24)

    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = CGSize(width: 0, height: 2)
    self.layer.shadowOpacity = 0.4
    self.layer.shadowRadius = 4

    self.layer.borderColor = UIColor.black.cgColor
    self.layer.borderWidth = 1.0

    self.translatesAutoresizingMaskIntoConstraints = false
    }
}
