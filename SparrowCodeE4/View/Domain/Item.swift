//
//  Item.swift
//  SparrowCodeE4
//
//  Created by Коцур Тарас Сергійович on 10.03.2023.
//

import Foundation

struct Item {
  let index: Int
  private(set) var isSelected: Bool = false
  
  mutating func set(isSelected: Bool) {
    guard self.isSelected != isSelected else { return }
    self.isSelected = isSelected
  }
  
  mutating func toggle() {
    isSelected.toggle()
  }
}

extension Item: Hashable { }
