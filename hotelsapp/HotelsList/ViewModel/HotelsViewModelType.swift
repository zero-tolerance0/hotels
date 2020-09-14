//
//  HotelsViewModelType.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol HotelsViewModelInput {
    var refreshControlAction: PublishSubject<Void> { get }
    func moveToHotelDetails(_ hotelId: Int)
    func handleSort(_ sortOption: SortOption)
}

protocol HotelsViewModelOutput {
    var isBusy: BehaviorRelay<Bool> { get }
    var hotels: BehaviorRelay<[Hotel]> { get }
}

protocol HotelsViewModelType {
    var input: HotelsViewModelInput { get }
    var output: HotelsViewModelOutput { get }
}

extension HotelsViewModelType where Self: HotelsViewModelInput & HotelsViewModelOutput {
    var input: HotelsViewModelInput { return self }
    var output: HotelsViewModelOutput { return self }
}
