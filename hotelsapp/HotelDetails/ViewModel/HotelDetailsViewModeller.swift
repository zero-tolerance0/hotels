//
//  HotelDetailsViewModeller.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class HotelDetailsViewModel: HotelDetailsViewModelType {
    
    var cellTitles: [String] = ["Name", "Rating", "Address", "Distance"]
    var cellDetails: [String] = ["Name", "Rating", "Address", "Distance"]
    var hotelImageUrl: String?
    
    let baseImageUrl = "https://bitbucket.org/instadevteam/tests/raw/63a9ecea18ca79c275a2eeafd95bc37f857cf2ec/1.2/"
    var isBusy = BehaviorRelay(value: false)
    var hotelDetails: BehaviorRelay<HotelDetails?> = BehaviorRelay(value: nil)
    let hotelDetailsApi: HotelDetailsApi
    let disposeBag = DisposeBag()
    let hotelId: Int
    private let coordinator: AppCoordinator
    
    //MARK: -- Buttons Actions
    var refreshControlAction: PublishSubject<Void> = PublishSubject()

    init(hotelId: Int, hotelDetailsApi: HotelDetailsApi, coordinator: AppCoordinator) {
        self.hotelId = hotelId
        self.hotelDetailsApi = hotelDetailsApi
        self.coordinator = coordinator
        setupBtnActions()
        getHotelDetails()
    }
}

extension HotelDetailsViewModel{
    func setupBtnActions(){
        self.refreshControlAction
            .asObservable()
            .subscribe(onNext: {
                debugPrint("refresh control touched")
                self.getHotelDetails()
            }).disposed(by: disposeBag)
    }
    
    func getHotelDetails() -> Void{
        isBusy.accept(true)
        let hotelDetailsObservable = hotelDetailsApi.getHotelDetails(hotelId)
        hotelDetailsObservable.subscribe(onNext: { (result) in
            switch result {
            case .success(let hotelDetails):
                self.cellDetails.insert(hotelDetails.name, at: 0)
                self.cellDetails.insert(String(hotelDetails.stars) + "/5.0", at: 1)
                self.cellDetails.insert(hotelDetails.address, at: 2)
                self.cellDetails.insert(String(hotelDetails.distance) + " m away", at: 3)
                if let image = hotelDetails.image{
                    self.hotelImageUrl = self.baseImageUrl + image
                }
                self.hotelDetails.accept(hotelDetails)
            case .failure(let err):
                debugPrint("Failed to fetch Hotels with err \(err.localizedDescription)")
                self.coordinator.handleErrorAlert(error: err)
            }
            self.isBusy.accept(false)
        }, onError: { (err) in
            self.isBusy.accept(false)
            debugPrint("Hotel Details request failed with error \(err.localizedDescription)")
            self.coordinator.handleErrorAlert(error: ApiError(error: err))
        }, onCompleted: {
            debugPrint("Hotel Details request completed")
        }) {
            debugPrint("Hotel Details request disposed")
        }.disposed(by: disposeBag)
    }
}


// MARK: - Input
extension HotelDetailsViewModel: HotelDetailsViewModelInput{
}

// MARK: - Output
extension HotelDetailsViewModel: HotelDetailsViewModelOutput{
}
