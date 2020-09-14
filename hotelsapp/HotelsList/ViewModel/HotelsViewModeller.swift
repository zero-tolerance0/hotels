//
//  HotelsViewModeller.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

public enum SortOption: Int{
    case byRating = 0
    case byDistance = 1
    case noSort = 2
}

final class HotelsViewModel: HotelsViewModelType {
    
    let disposeBag = DisposeBag()
    
    //MARK: -- Main Items
    var isBusy = BehaviorRelay(value: false)
    var hotels: BehaviorRelay<[Hotel]> = BehaviorRelay(value: [])
    private var unsortedHotels = [Hotel]()
    private let hotelsListApi: HotelsListApi
    private let coordinator: AppCoordinator
    
    //MARK: -- Buttons Actions
    var refreshControlAction: PublishSubject<Void> = PublishSubject()
    
    init(hotelsListApi: HotelsListApi, coordinator: AppCoordinator) {
        self.hotelsListApi = hotelsListApi
        self.coordinator = coordinator
        setupBtnActions()
        getHotels()
    }
}

extension HotelsViewModel{
    func setupBtnActions(){
        self.refreshControlAction
            .asObservable()
            .subscribe(onNext: {
                debugPrint("refresh control touched")
                self.getHotels()
            }).disposed(by: disposeBag)
    }
    
    func getHotels() -> Void{
        isBusy.accept(true)
        let hotelsObservable = hotelsListApi.getHotels()
        hotelsObservable.subscribe(onNext: { (result) in
            self.isBusy.accept(false)
            switch result {
            case .success(let hotelsList):
                self.unsortedHotels = hotelsList
                self.hotels.accept(hotelsList)
            case .failure(let err):
                debugPrint("Failed to fetch Hotels with err \(err.localizedDescription)")
                self.coordinator.handleErrorAlert(error: err)
            }
        }, onError: { (err) in
            self.isBusy.accept(false)
            debugPrint("Hotels request failed with error \(err.localizedDescription)")
            self.coordinator.handleErrorAlert(error: ApiError(error: err))
        }, onCompleted: {
            debugPrint("Hotels request completed")
        }) {
            debugPrint("Hotels request disposed")
        }.disposed(by: disposeBag)
    }
}

// MARK: - Input
extension HotelsViewModel: HotelsViewModelInput{
    
    func handleSort(_ sortOption: SortOption){
        switch sortOption {
        case .byRating:
            let sortedHotels = unsortedHotels.sorted(by: { $0.stars > $1.stars })
            self.hotels.accept(sortedHotels)
        case .byDistance:
            let sortedHotels = unsortedHotels.sorted(by: { $0.distance < $1.distance })
            self.hotels.accept(sortedHotels)
        default:
            self.hotels.accept(unsortedHotels)
        }
    }
    
    func moveToHotelDetails(_ hotelId: Int){
        coordinator.moveToHotelDetailsWith(hotelId)
    }
}

// MARK: - Output
extension HotelsViewModel: HotelsViewModelOutput{
}
