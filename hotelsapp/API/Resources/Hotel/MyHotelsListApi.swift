//
//  HotelsListApi.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import Foundation
import RxSwift

final class MyHotelsListApi: HotelsListApi {
    
    private let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func getHotels() -> Observable<Result<[Hotel], ApiError>> {
        let hotelsApiRequest = HotelsApiRequest(path: "/63a9ecea18ca79c275a2eeafd95bc37f857cf2ec/1.2/0777.json", method: .GET)
        return apiClient.requestHotelsList(hotelsApiRequest)
    }
}
