//
//  HotelDetails.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import Foundation



public struct HotelDetails: HotelProtocol, Codable {
    let id: Int
    let name: String
    let address: String
    let stars: Double
    let distance: Double
    let image: String?
    let suitesAvailable: String
    let lat: Double
    let lon: Double

    enum CodingKeys: String, CodingKey {
         case id, name, address, stars, distance, image, lat, lon
         case suitesAvailable    = "suites_availability"
    }
}
