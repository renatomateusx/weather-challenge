//
//  HomeViewController.swift
//  Weather-Challenge
//
//  Created by Renato Mateus on 15/11/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var showActionButton: UIButton!
    @IBOutlet weak var resultContentView: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var currentConditionLabel: UILabel!
    @IBOutlet weak var precipitationChanceLabel: UILabel!
    
    
    // MARK: - Private Properties
    var loading: UIActivityIndicatorView?
    internal let viewModel = HomeViewModel(with: WeatherService())
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
}

// MARK: - Setup UI
extension HomeViewController {
    
    func setupUI() {
        loading = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        loading?.color = UIColor.darkGray
        loading?.translatesAutoresizingMaskIntoConstraints = false
        if let loading = loading {
            self.view.addSubview(loading)
            loading.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            loading.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        }
        
        /// Result Content View shadow
        resultContentView.layer.cornerRadius = 20.0
        resultContentView.clipsToBounds = true
        resultContentView.layer.masksToBounds = false
        resultContentView.layer.shadowColor = UIColor.gray.cgColor
        resultContentView.layer.shadowOffset = CGSize(width: -1, height: 5)
        resultContentView.layer.shadowOpacity = 0.7
        resultContentView.layer.shadowRadius = 4.0
        
        self.showActionButton.addTarget(self, action: #selector(didActionButtonTapped), for: .touchUpInside)
        
        self.resultContentView.isHidden = true
    }
    
    /// Shows project's default loading on the UITableView.
    func showLoad() {
        DispatchQueue.main.async {
            self.loading?.startAnimating()
        }
    }
    
    /// Hides any visible loading from the UITableView.
    func hideLoad() {
        DispatchQueue.main.async {
            self.loading?.stopAnimating()
        }
    }
    
    func showDataRetrieved(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = "Temperature: \(weather.temperature )"
            self.pressureLabel.text = "Pressure: \(weather.wind)"
            self.humidityLabel.text = "Humidity: Not informed"
            self.currentConditionLabel.text = "Current Condition: \(weather.description)"
            self.precipitationChanceLabel.text = "Chances of precipitation: Not informed"
            self.resultContentView.isHidden = false
        }
    }
    
    func hideDataRetrieved() {
        DispatchQueue.main.async {
            self.resultContentView.isHidden = true
            self.alert(title: "Oops", message: "Nothing to show")
        }
    }
}

// MARK: - Setup Data

extension HomeViewController {
    func setupData() {
        self.viewModel.delegate = self
    }
}

// MARK: - ViewControllerViewModelDelegate

extension HomeViewController: HomeViewModelDelegate {
    func onSuccessFetchingWeather(weather: WeatherModel) {
        self.showDataRetrieved(weather: weather)
        self.hideLoad()
    }
    
    func onFailureFetchingWeather(error: Error) {
        DispatchQueue.main.async {
            self.alert(title: "Oops!", message: error.localizedDescription)
        }
    }
}

// MARK: - Actions

extension HomeViewController {
    @objc
    func didActionButtonTapped() {
        self.showLoad()
        if let textCity = self.cityTextField.text {
            self.viewModel.fetchData(textCity.replacingOccurrences(of: " ", with: "+"))
        }
    }
}
