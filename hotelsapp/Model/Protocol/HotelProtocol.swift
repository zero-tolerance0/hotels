//
//  HotelProtocol.swift
//  hotelsapp
//
//  Created by didarkam on 6/25/20.
//  Copyright © 2020 indev. All rights reserved.
//

import Foundation

protocol HotelProtocol {
    var id: Int { get }
    var name: String { get }
    var address: String { get }
    var stars: Double { get }
    var distance: Double { get }
    var suitesAvailable: String { get }
}
