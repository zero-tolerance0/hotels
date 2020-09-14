//
//  HotelsApiRequest.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import Foundation

struct HotelsApiRequest: ApiRequest {
    
    let root = "https://bitbucket.org/instadevteam/tests/raw"
    let path: String
    let query: [String:CustomStringConvertible]
    let method: HTTPMethod
    let contentType: HTTPRequestContentType
    var body: Data?
    
    init(path: String, query: [String:CustomStringConvertible] = [:], method: HTTPMethod = .GET) {
        self.path = path
        self.query = query
        self.method = method
        self.contentType = .text
        self.body = nil
    }
}
