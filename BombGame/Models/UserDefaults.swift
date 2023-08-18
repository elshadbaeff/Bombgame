//
//  UserDefaults.swift
//  BombGame
//
//  Created by Александра Савчук on 11.08.2023.
//

import Foundation

struct UserDefaultsManager {
  let defaults = UserDefaults.standard
  static var shared = UserDefaultsManager()

  private let defaultFonMusic = "fon1"
  private let defaultTimerMusic = "timer1"
  private let defaultExplosionMusic = "explosion1"

  var fonMusic: String {
    get {
      return defaults.string(forKey: "fonMusic") ?? defaultFonMusic
    }
    set {
      defaults.set(newValue, forKey: "fonMusic")
    }
  }

  var timerMusic: String {
    get {
      return defaults.string(forKey: "timerMusic") ?? defaultTimerMusic
    }
    set {
      defaults.set(newValue, forKey: "timerMusic")
    }
  }

  var explosionMusic: String {
    get {
      return defaults.string(forKey: "explosionMusic") ?? defaultExplosionMusic
    }
    set {
      defaults.set(newValue, forKey: "explosionMusic")
    }
  }

  var selectedCategories: [String] {
    get {
      return defaults.array(forKey: "selectedCategories") as? [String] ?? []
    }
    set {
      defaults.set(newValue, forKey: "selectedCategories")
    }
  }

  var taskSwitchState: Bool {
    get {
      return defaults.bool(forKey: "taskSwitchState")
    }
    set {
      defaults.set(newValue, forKey: "taskSwitchState")
    }
  }

  var musicSwitchState: Bool {
    get {
      return defaults.bool(forKey: "musicSwitchState")
    }
    set {
      defaults.set(newValue, forKey: "musicSwitchState")
    }
  }

  var gameDuration: TimeInterval {
    get {
      return defaults.double(forKey: "gameDuration") != 0 ? defaults.double(forKey: "gameDuration") : 10
    }
    set {
      defaults.set(newValue, forKey: "gameDuration")
    }
  }

  var questions: String {
    get {
      return defaults.string(forKey: "currentQuestion") ?? "Назовите цветок"
    }
    set {
      defaults.set(newValue, forKey: "currentQuestion")
    }
  }
}

