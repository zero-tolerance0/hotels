//
//  FillableProtocol.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import Foundation

protocol FillableProtocol {
    associatedtype DataType
    
    func fill(_ data: DataType)
}
