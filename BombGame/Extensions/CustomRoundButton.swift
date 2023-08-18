//
//  CustomRoundButton.swift
//  BombGame
//
//  Created by Александра Савчук on 07.08.2023.
//

import UIKit

class CustomRoundButton: UIButton {
  var systemImageName: String? {
    didSet {
      updateSystemImage()
    }
  }

  init(systemImageName: String) {
    super.init(frame: .zero)
    self.systemImageName = systemImageName
    setupButton()
    updateSystemImage()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupButton()
    updateSystemImage()
  }

  private func setupButton() {
    self.layer.cornerRadius = 40
    self.backgroundColor = .purpleColor
    self.tintColor = .yellowLabel

    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = CGSize(width: 0, height: 2)
    self.layer.shadowOpacity = 0.4
    self.layer.shadowRadius = 4

    self.layer.borderWidth = 1.0

    self.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      self.widthAnchor.constraint(equalToConstant: 80),
      self.heightAnchor.constraint(equalToConstant: 80)
    ])

    updateImageSize()
  }

  private func updateImageSize() {
    let newSize = CGSize(width: 60, height: 60)
    if let currentImage = image(for: .normal) {
      let resizedImage = currentImage.resized(to: newSize)
      setImage(resizedImage, for: .normal)
    }
  }

  private func updateSystemImage() {
    if let imageName = systemImageName {
      if let image = UIImage(systemName: imageName) {
        let tintedImage = image.withTintColor(.yellowLabel)
        setImage(tintedImage, for: .normal)
        updateImageSize()
      }
    }
  }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}
