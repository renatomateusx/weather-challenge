//
//  WeatherServiceMockFailure.swift
//  Weather-ChallengeTests
//
//  Created by Renato Mateus on 16/11/21.
//

import Foundation
@testable import Weather_Challenge

class WeatherServiceMockFailure: WeatherServiceProtocol {
    func fetchData(_ city: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        completion(.failure(NSError(domain: "No data was downloaded.",
                                    code: 400,
                                    userInfo: nil)))
    }
}
