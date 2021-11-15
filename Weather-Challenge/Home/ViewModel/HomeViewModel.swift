//
//  HomeViewModel.swift
//  Weather-Challenge
//
//  Created by Renato Mateus on 15/11/21.
//

import Foundation
protocol HomeViewModelDelegate: AnyObject {
    func onSuccessFetchingWeather(weather: WeatherModel)
    func onFailureFetchingWeather(error: Error)
}

class HomeViewModel {
    
    // MARK: - Private Properties
    let weatherService: WeatherServiceProtocol
    var delegate: HomeViewModelDelegate?
    // MARK: - Inits
    
    init(with service: WeatherServiceProtocol) {
        self.weatherService = service
    }
    
    func fetchData(_ city: String) {
        weatherService.fetchData(city) { result in
            switch result {
            
            case .success(let weather):
                self.delegate?.onSuccessFetchingWeather(weather: weather)
            case .failure(let error):
                self.delegate?.onFailureFetchingWeather(error: error)
            }
        }
    }
}
