//
//  CALayer.swift
//  BombGame
//
//  Created by Александра Савчук on 11.08.2023.
//

import UIKit

extension CALayer {
  func pauseAnimation() {
    let pausedTime = convertTime(CACurrentMediaTime(), from: nil)
    speed = 0.0
    timeOffset = pausedTime
  }

  func resumeAnimation() {
    let pausedTime = timeOffset
    speed = 1.0
    timeOffset = 0.0
    beginTime = 0.0
    let timeSincePause = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
    beginTime = timeSincePause
  }
}
