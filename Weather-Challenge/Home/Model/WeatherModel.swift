//
//  WeatherModel.swift
//  Weather-Challenge
//
//  Created by Renato Mateus on 15/11/21.
//

import Foundation

struct WeatherModel: Codable {
    let temperature, wind, description: String
    let forecast: [Forecast]
}

// MARK: - Forecast
struct Forecast: Codable {
    let day, temperature, wind: String
}
