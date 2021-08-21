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
    @IBOutlet weak var forecastCollectionView: UICollectionView!
    @IBOutlet weak var temperatureView: UIView!
    
    let viewModel = CityScreenViewModel()
    var selectedAddress: Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requestForWeather = WeatherRequest(latitude: Double(selectedAddress?.latitude ?? "0.0") ?? 0.0, longitude: Double(selectedAddress?.latitude ?? "0.0") ?? 0.0, forecastType: .hourly)
        viewModel.callWeatherAPi(for: requestForWeather)
        
        let requestForForecast = WeatherRequest(latitude: Double(selectedAddress?.latitude ?? "0.0") ?? 0.0, longitude: Double(selectedAddress?.latitude ?? "0.0") ?? 0.0, forecastType: .hourly)
        viewModel.callForecastAPi(for: requestForForecast)
        self.title = selectedAddress?.address
        
        self.bindDataForWeather()
        self.bindDataForForecast()
    }
    
    func bindDataForWeather(){
        viewModel.weatherData.bind { [weak self] response in
            let kelvinTemp = response?.main?.temp ?? 0
            DispatchQueue.main.async {
                self?.temperatureView.isHidden = false
                self?.lblTemperature.text = "\(Int(kelvinTemp - 273.15))°C"
                self?.lblHumidity.text = "Humidity :\(response?.main?.humidity ?? 00)%"
                self?.lblWeather.text = "Weather : \(response?.weather?[0].weatherDescription ?? "")"
                self?.lblWind.text = "Wind : \(GlobalMethod.sharedInstance.getSpeedKilometersPerHour(spped: response?.wind?.speed ?? 0.0))"
            }
        }
    }
    
    func bindDataForForecast(){
        viewModel.ForecastData.bind { [weak self] response in
            print(response?.city?.name)
            DispatchQueue.main.async {
                self?.forecastCollectionView.reloadData()
            }
        }
    }
}

extension CityScreenViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.ForecastData.value?.list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (forecastCollectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as? ForecastCollectionViewCell
        cell?.forecastData = viewModel.ForecastData.value?.list?[indexPath.row]
        return cell!
    }
    
    
}
