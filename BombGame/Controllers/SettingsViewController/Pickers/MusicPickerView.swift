//
//  MusicPickerView.swift
//  BombGame
//
//  Created by Elshad Babaev on 11.08.2023.
//

import UIKit

protocol MusicPickerDelegate: AnyObject {
  func didSelectMusicValue(_ value: String)
}

class MusicPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
  
  weak var musicPickerDelegate: MusicPickerDelegate?
  
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
    return DataManager.shared.arrayFon[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let selectedValue = DataManager.shared.arrayFon[row]
    musicPickerDelegate?.didSelectMusicValue(selectedValue)
  }
}
