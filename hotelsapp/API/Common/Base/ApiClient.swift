//
//  ApiClient.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import Foundation
import RxSwift

protocol ApiClient {
    func requestHotelsList(_ apiRequest: ApiRequest) -> Observable<Result<[Hotel], ApiError>>
    func requestHotelDetails(_ apiRequest: ApiRequest) -> Observable<Result<HotelDetails, ApiError>>
}
