//
//  Rule.swift
//  BombGame
//
//  Created by Kirill Taraturin on 09.08.2023.
//

import Foundation

struct Rule {
  var number: String
  var name: String
  
  static func getRules() -> [Rule] {
    var listRules: [Rule] = []
    for (index, rule) in rules.enumerated() {
      let ruleNumber = "\(index + 1)"
      listRules.append(Rule(number: ruleNumber, name: rule))
    }
    return listRules
  }
}

private var rules = [
  "Все игроки становятся в круг.",
  "Первый игрок берет телефон и нажимает кнопку:",
  "На экране появляется вопрос “Назовите Фрукт“",
  "Игрок отвечает на вопрос и после правильного ответа передает телефон следующему игроку (правильность ответа определяют другие участники)",
  "Игроки по кругу отвечают на один и тот же вопрос до тех пор, пока не взорвется бомба",
  "Проигравшим считается тот, в чьих руках взорвалась бомба",
  "Если в настройках выбран режим игры “С Заданиями”, то проигравший выполняет задание"
]
