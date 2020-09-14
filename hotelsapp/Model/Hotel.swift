//
//  Hotel.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import Foundation

public struct Hotel: HotelProtocol, Codable {
    let id: Int
    let name: String
    let address: String
    let stars: Double
    let distance: Double
    let suitesAvailable: String

    enum CodingKeys: String, CodingKey {
         case id, name, address, stars, distance
         case suitesAvailable    = "suites_availability"
    }
}
