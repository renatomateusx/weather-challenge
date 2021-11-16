//
//  WeatherServiceMockSuccess.swift
//  Weather-ChallengeTests
//
//  Created by Renato Mateus on 16/11/21.
//

import Foundation
@testable import Weather_Challenge

class WeatherServiceMockSuccess: WeatherServiceProtocol {
    func fetchData(_ city: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        let fakeDataModel: WeatherModel = WeatherModel(temperature: "26",
                                                       wind: "16km",
                                                       description: "Partity Cloudly",
                                                       forecast: [Forecast(day: "Day 1",
                                                                          temperature: "26",
                                                                          wind: "15km")])
        completion(.success(fakeDataModel))
    }
}
