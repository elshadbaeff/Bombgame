//
//  GradientView.swift
//  BombGame
//
//  Created by Александра Савчук on 07.08.2023.
//

import UIKit

class GradientView: UIView {
  override class var layerClass: AnyClass {
    return CAGradientLayer.self
  }
  
  var gradientLayer: CAGradientLayer {
    return layer as! CAGradientLayer
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let topColor = UIColor(red: 247/255, green: 252/255, blue: 7/255, alpha: 1)
    let bottomColor = UIColor(red: 1, green: 155/255, blue: 4/255, alpha: 1)

    gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
