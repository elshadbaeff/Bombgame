//
//  TickPickerView.swift
//  BombGame
//
//  Created by Elshad Babaev on 11.08.2023.
//

import UIKit

protocol TickPickerDelegate: AnyObject {
  func didSelectTickValue(_ value: String)
}

class TickPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
  
  weak var tickPickerDelegate: TickPickerDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.delegate = self
    self.dataSource = self
    self.translatesAutoresizingMaskIntoConstraints = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return 3
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return DataManager.shared.arrayTick[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let selectedValue = DataManager.shared.arrayTick[row]
    tickPickerDelegate?.didSelectTickValue(selectedValue)
  }
}
