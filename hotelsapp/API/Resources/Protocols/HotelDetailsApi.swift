//
//  HotelDetailsApi.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import Foundation
import RxSwift

public protocol HotelDetailsApi {
    
    func getHotelDetails(_ hotelId: Int) -> Observable<Result<HotelDetails, ApiError>>
}
