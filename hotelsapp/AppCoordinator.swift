//
//  AppCoordinator.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import UIKit
import RxSwift

final class AppCoordinator: BaseCoordinator {
    
    // MARK: - Private Properties 🕶
    private let apiClient: ApiClient
    private let hotelsListApi: HotelsListApi
    private let hotelDetailsApi: HotelDetailsApi
    var myNavigationController: UINavigationController?
    
    // MARK: - Constructor 🏗
    override init() {
        self.apiClient = HotelsApiClient()
        self.hotelsListApi = MyHotelsListApi(apiClient: self.apiClient)
        
        self.hotelDetailsApi = MyHotelDetailsApi(apiClient: apiClient)
    }
    
    //
    override func start() {
        self.setViewController()
    }
}

// MARK: - Setup 🛠
extension AppCoordinator {
    
    func setViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        let hotelsListViewModel = HotelsViewModel(hotelsListApi: hotelsListApi, coordinator: self)
        let hotelsListViewController = UIStoryboard.get(HotelsListViewController.self)
        hotelsListViewController.viewModel = hotelsListViewModel
        myNavigationController = UINavigationController(rootViewController: hotelsListViewController)
        window.rootViewController = myNavigationController
    }
    
    func moveToHotelDetailsWith(_ hotelId: Int){
        let hotelDetailsViewController = UIStoryboard.get(HotelDetailsViewController.self)
        let hotelsDetailsViewModel = HotelDetailsViewModel(hotelId: hotelId, hotelDetailsApi: hotelDetailsApi, coordinator: self)
        hotelDetailsViewController.viewModel = hotelsDetailsViewModel
        myNavigationController?.pushViewController(hotelDetailsViewController, animated: true)
    }
    
    func handleErrorAlert(error: ApiError){
        let alert = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        myNavigationController?.present(alert, animated: true, completion: nil)
    }
}
