//
//  WeatherEndPoint.swift
//  Weather-Challenge
//
//  Created by Renato Mateus on 15/11/21.
//

import Foundation

struct WeatherEndpoint {
    let city: String

    var host: String {
        return Constants.weatherURL
    }

    var path: String {
        return "weather/\(city)"
    }
    
    var url: URL {
        return URL(string: "\(host)\(path)")!
    }

    var headers: [String: String] {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
}
