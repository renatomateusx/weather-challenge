//
//  HomeViewController.swift
//  Weather-Challenge
//
//  Created by Renato Mateus on 15/11/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Private Properties
    var loading: UIActivityIndicatorView?
    internal let viewModel = HomeViewModel(with: WeatherService())
    var weather: WeatherModel?
    
    // MARK: - Outlets
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var showActionButton: UIButton!
    
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
        
        self.showActionButton.addTarget(self, action: #selector(didActionButtonTapped), for: .touchUpInside)
    }
    
    /// Shows project's default loading on the UITableView.
    func showLoad() {
        loading?.startAnimating()
    }
    
    /// Hides any visible loading from the UITableView.
    func hideLoad() {
        self.loading?.stopAnimating()
    }
    
    func showDataRetrieved() {
        
    }
    
    func hideDataRetrieved() {
        
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
        self.weather = weather
        
        self.showDataRetrieved()
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
            self.viewModel.fetchData(textCity)
        }
    }
}
