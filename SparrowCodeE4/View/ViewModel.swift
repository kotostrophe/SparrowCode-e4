//
//  ViewModel.swift
//  SparrowCodeE4
//
//  Created by Коцур Тарас Сергійович on 10.03.2023.
//

import Foundation

typealias Collection = Array<Item>

protocol ViewModelProtocol: AnyObject {
  var data: Collection { get }
  var didUpdateData: ((Collection) -> Void)? { get set }
  
  func shuffle()
  func toggle(itemBy index: Collection.Index)
  func select(itemBy index: Collection.Index)
  func deselect(itemBy index: Collection.Index)
}

final class ViewModel: ViewModelProtocol {
  
  // MARK: - Properties
  
  private(set) var data: Collection
  
  // MARK: - Update handler property
  
  var didUpdateData: ((Collection) -> Void)?
  
  // MARK: - Initializers
  
  init() {
    data = (0 ..< 24).map { index in .init(index: index) }
  }
  
  
  // MARK: - Methods
  
  func shuffle() {
    data.shuffle()
    didUpdateData?(data)
  }
  
  func toggle(itemBy index: Collection.Index) {
    switch data[index].isSelected {
      case true: deselect(itemBy: index)
      case false: select(itemBy: index)
    }
  }
  
  func select(itemBy index: Collection.Index) {
    var updatedItem = data.remove(at: index)
    updatedItem.set(isSelected: true)
    data.insert(updatedItem, at: .zero)
    didUpdateData?(data)
  }
  
  func deselect(itemBy index: Collection.Index) {
    data[index].set(isSelected: false)
    didUpdateData?(data)
  }
}
