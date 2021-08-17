//
//  CityScreenViewModel.swift
//  MobiquityAssignment
//
//  Created by Akash Pal on 17/08/21.
//

import Foundation


class CityScreenViewModel: BaseViewModel {
    var weatherData: CurrentWeatherModelClass? {
        didSet {
            delegate?.viewModelDidUpdate(sender: self)
        }
    }
    
    func callWeatherAPi(for model: WeatherRequest) {
        NetworkManager.fetchWaetherData(for: model, success: { [weak self] data in
            do{
                let respnse = try JSONDecoder().decode(CurrentWeatherModelClass.self, from: data)
                self?.weatherData = respnse
            } catch {
                print("Unable to parse")
            }
        }, failure: { [weak self] error in
            self?.delegate?.viewModelUpdateFailed(error: error)
        })
    }
}
