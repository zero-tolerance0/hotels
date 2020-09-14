//
//  ApiRequest.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import Foundation

enum HTTPMethod : String {
    case GET = "GET"
}

enum HTTPRequestContentType: CustomStringConvertible {
    case text
    case json
    case formUrlEncoded
    
    var description: String {
        switch self {
        case .text: return ""
        case .json: return "application/json"
        case .formUrlEncoded: return "application/x-www-form-urlencoded"
        }
    }
}

protocol ApiRequest {
    var root: String { get }
    var query: [String:CustomStringConvertible] { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var contentType: HTTPRequestContentType { get }
    var body: Data? { get }
}
