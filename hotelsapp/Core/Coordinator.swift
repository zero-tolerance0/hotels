//
//  Coordinator.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import UIKit
import RxSwift

protocol Coordinator: class {
    var parentCoordinator: Coordinator? { get set }
    var tabBarController: UITabBarController { set get }
    var navigationController: UINavigationController { set get }
    
    func start()
    func start(coordinator: Coordinator)
    func didFinish(coordinator: Coordinator)
}

class BaseCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    var tabBarController = UITabBarController()
    var navigationController = UINavigationController()
    
    var window = UIWindow(frame: UIScreen.main.bounds)
    
    // MARK: - Constructor 🏗
    init() {
    }
    
    func start() {
        fatalError("Start method must be implemented")
    }
    
    func start(coordinator: Coordinator) {
        self.childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func didFinish(coordinator: Coordinator) {
        if let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) {
            self.childCoordinators.remove(at: index)
        }
    }
}
