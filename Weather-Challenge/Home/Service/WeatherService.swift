//
//  WeatherService.swift
//  Weather-Challenge
//
//  Created by Renato Mateus on 15/11/21.
//

import Foundation

protocol WeatherServiceProtocol: AnyObject {
    func fetchData(_ city: String, completion: @escaping(Result<WeatherModel, Error>) -> Void)
}

class WeatherService {
    private var service: NetworkService
    
    init(service: NetworkService = NetworkService()) {
        self.service = service
    }
}

extension WeatherService: WeatherServiceProtocol {
    func fetchData(_ city: String, completion: @escaping(Result<WeatherModel, Error>) -> Void) {
        let endpoint = WeatherEndpoint(city: city)
        _ = service.request(for: endpoint.url, completion: completion)
    }
}
