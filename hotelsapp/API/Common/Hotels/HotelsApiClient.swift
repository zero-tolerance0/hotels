//
//  HotelsApiClient.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import Foundation
import RxSwift

final class HotelsApiClient: ApiClient {
    
    private let headers: [String:String]
    private let urlSession: URLSession
    
    init () {
        self.headers = [:]
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.httpCookieAcceptPolicy = .never
        sessionConfig.httpShouldSetCookies = false
        self.urlSession = URLSession(configuration: sessionConfig)
    }
    
    func requestHotelsList(_ apiRequest: ApiRequest) -> Observable<Result<[Hotel], ApiError>>{
        let request = makeURLRequest(apiRequest)
        return Observable.create({ (observer) -> Disposable in
            let task: URLSessionTask
            task = self.urlSession.dataTask(with: request) { (data, response, error) in
                
                if let error = error {
                    observer.onError(ApiError(error: error))
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    observer.onNext(.failure(ApiError.notReachedServer))
                  return
                }
                guard let data = data else {return}
                do {
                    let decoder = JSONDecoder()
                    let hotelsList = try decoder.decode([Hotel].self, from: data)
                    observer.onNext(.success(hotelsList))
                    observer.onCompleted()
                } catch let jsonError {
                    debugPrint(jsonError.localizedDescription)
                    observer.onNext(.failure(ApiError.incorrectDataReturned))
                    observer.onCompleted()
                    return
                }
            }
                task.resume()
            return Disposables.create {
                task.cancel()
            }
        })
    }
    
    func requestHotelDetails(_ apiRequest: ApiRequest) -> Observable<Result<HotelDetails, ApiError>>{
        let request = makeURLRequest(apiRequest)
        return Observable.create({ (observer) -> Disposable in
            let task: URLSessionTask
            task = self.urlSession.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    observer.onError(ApiError(error: error))
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    observer.onNext(.failure(ApiError.notReachedServer))
                  return
                }
                guard let data = data else {return}
                do {
                    let decoder = JSONDecoder()
                    let hotelDetails = try decoder.decode(HotelDetails.self, from: data)
                    observer.onNext(.success(hotelDetails))
                    observer.onCompleted()
                } catch let jsonError {
                    debugPrint(jsonError.localizedDescription)
                    observer.onNext(.failure(ApiError.incorrectDataReturned))
                    observer.onCompleted()
                    return
                }
                }
                task.resume()
            return Disposables.create {
                task.cancel()
            }
        })
    }
    
    private func makeURLRequest(_ apiRequest: ApiRequest) -> URLRequest {
        
        var urlComponents = URLComponents(string: apiRequest.root + apiRequest.path)!
        urlComponents.queryItems = apiRequest.query.map { URLQueryItem(name: $0, value: "\($1)") }
        
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        request.httpMethod = apiRequest.method.rawValue
        
        var headers: [String: String] = self.headers
        
        if apiRequest.contentType != .text {
            headers["Content-Type"] = String(describing: apiRequest.contentType)
        }
        
        headers.forEach { request.addValue($1, forHTTPHeaderField: $0) }
        
        request.httpBody = apiRequest.body as Data?
        
        return request
    }
}
