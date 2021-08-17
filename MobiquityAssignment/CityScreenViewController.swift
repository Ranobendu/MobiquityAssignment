//
//  CityScreenViewController.swift
//  MobiquityAssignment
//
//  Created by MAC on 16/08/21.
//

import UIKit

class CityScreenViewController: UIViewController {

    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblWeather: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    
    let viewModel = CityScreenViewModel()
    
    var selectedAddress: Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
       
        let request = WeatherRequest(latitude: Double(selectedAddress?.latitude ?? "0.0") ?? 0.0, longitude: Double(selectedAddress?.latitude ?? "0.0") ?? 0.0, forecastType: .daily)
        viewModel.callWeatherAPi(for: request)
        self.title = selectedAddress?.address
    }
}

extension CityScreenViewController: ViewModelDelegate {
    func viewModelDidUpdate(sender: BaseViewModel) {
        let kelvinTemp = viewModel.weatherData?.main?.temp ?? 0
        DispatchQueue.main.async {
            self.lblTemperature.text = "\(Int(kelvinTemp - 273.15))°C"
            self.lblHumidity.text = "Humidity :\(self.viewModel.weatherData?.main?.humidity ?? 00)%"
            self.lblWeather.text = "Weather : \(self.viewModel.weatherData?.weather?[0].weatherDescription ?? "")"
            self.lblWind.text = "Wind Information : \(GlobalMethod.sharedInstance.getSpeedKilometersPerHour(spped: self.viewModel.weatherData?.wind?.speed ?? 0.0))"
        }
    }
    
    func viewModelUpdateFailed(error: Error) {
        // Show alert
    }
}
