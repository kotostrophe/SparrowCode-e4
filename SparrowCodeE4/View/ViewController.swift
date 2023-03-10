//
//  ViewController.swift
//  SparrowCodeE4
//
//  Created by Коцур Тарас Сергійович on 10.03.2023.
//

import UIKit

class ViewController: UIViewController {
  
  enum Identifier {
    static let cell: String = "com.view.item.cell"
  }
  
  // MARK: - UI properties
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    tableView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: Identifier.cell)
    return tableView
  }()
  
  private lazy var tableViewDiffableDataSource: UITableViewDiffableDataSource<Section, Item> = {
    let dataSource = UITableViewDiffableDataSource<Section, Item>(tableView: tableView) { tableView, indexPath, item in
      var configuration = UIListContentConfiguration.cell()
      configuration.text = String(format: "%d", item.index)
      
      let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.cell, for: indexPath)
      cell.contentConfiguration = configuration
      cell.accessoryType = item.isSelected ? .checkmark: .none
      return cell
    }
    dataSource.defaultRowAnimation = .fade
    return dataSource
  }()
  
  // MARK: - Properties
  
  private let viewModel: ViewModelProtocol
  
  // MARK: - Initializers
  
  init(viewModel: ViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    
    configureNavigationItem()
    configuraTableViewDiffableDataSource(tableView)
    configureViewModelHandlers(viewModel)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Life cycle methods

  override func loadView() {
    view = tableView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateTableView(with: viewModel.data)
  }
  
  // MARK: - Configuration methods
  
  private func configuraTableViewDiffableDataSource(_ tableView: UITableView) {
    tableView.dataSource = tableViewDiffableDataSource
  }
  
  private func configureNavigationItem() {
    let shuffleBarItem = UIBarButtonItem(title: "Shuffle", style: .plain, target: self, action: #selector(shuffleArray))
    navigationItem.setRightBarButton(shuffleBarItem, animated: false)
  }
  
  private func configureViewModelHandlers(_ viewModel: ViewModelProtocol) {
    viewModel.didUpdateData = updateTableView(with:)
  }
  
  // MARK: - Action
  
  @objc
  private func shuffleArray() {
    viewModel.shuffle()
  }
  
  private func updateTableView(with data: Collection) {
    var snapshot = tableViewDiffableDataSource.snapshot()
    snapshot.deleteAllItems()
    snapshot.appendSections([.main])
    snapshot.appendItems(data, toSection: .main)
    
    tableViewDiffableDataSource.apply(snapshot)
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    viewModel.toggle(itemBy: indexPath.item)
  }
}

extension ViewController {
  enum Section {
    case main
  }
}

extension ViewController.Section: Hashable { }
