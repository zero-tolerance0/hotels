//
//  HotelDetailsViewModelType.swift
//  hotelsapp
//
//  Created by zerohero on 6/25/20.
//  Copyright © 2020 indev. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

protocol HotelDetailsViewModelInput {
    var refreshControlAction: PublishSubject<Void> { get }
}

protocol HotelDetailsViewModelOutput {
    var cellTitles: [String] { get }
    var cellDetails: [String] { get }
    var hotelImageUrl: String? { get }
    var hotelDetails: BehaviorRelay<HotelDetails?> { get }
    var isBusy: BehaviorRelay<Bool> { get }
}

protocol HotelDetailsViewModelType {
    var input: HotelDetailsViewModelInput { get }
    var output: HotelDetailsViewModelOutput { get }
}

extension HotelDetailsViewModelType where Self: HotelDetailsViewModelInput & HotelDetailsViewModelOutput {
    var input: HotelDetailsViewModelInput { return self }
    var output: HotelDetailsViewModelOutput { return self }
}
