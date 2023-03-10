//
//  AppDelegate.swift
//  SparrowCodeE4
//
//  Created by Коцур Тарас Сергійович on 05.03.2023.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
  
  // MARK: - Properties
  
  var window: UIWindow?
  
  // MARK: - Life cycle methods

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let window = UIWindow()
    
    let viewModel = ViewModel()
    let viewController = ViewController(viewModel: viewModel)
    viewController.title = "Task 4"
    let navigationController = UINavigationController(rootViewController: viewController)
    
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    
    self.window = window
    
    return true
  }
}

