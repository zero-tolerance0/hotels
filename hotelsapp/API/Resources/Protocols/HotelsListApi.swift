//
//  HotelsListApi.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import Foundation
import RxSwift

public protocol HotelsListApi {
    
    func getHotels() -> Observable<Result<[Hotel], ApiError>>
}
