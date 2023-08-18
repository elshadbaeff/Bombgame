//
//  ExplosionPickerView.swift
//  BombGame
//
//  Created by Elshad Babaev on 11.08.2023.
//

import UIKit

protocol ExplosionPickerDelegate: AnyObject {
  func didSelectExplosionValue(_ value: String)
}

class ExplosionPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
  
  weak var explosionPickerDelegate: ExplosionPickerDelegate?
  
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
    return DataManager.shared.arrayExplosion[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let selectedValue = DataManager.shared.arrayExplosion[row]
    explosionPickerDelegate?.didSelectExplosionValue(selectedValue)
  }
}
