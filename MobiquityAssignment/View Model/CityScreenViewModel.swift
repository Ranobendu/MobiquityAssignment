//
//  CityScreenViewModel.swift
//  MobiquityAssignment
//
//  Created by Akash Pal on 17/08/21.
//

import Foundation


class CityScreenViewModel {
    
    var weatherData: Observable<CurrentWeatherModelClass?> = Observable(nil)
    var ForecastData: Observable<WeatherForecastModelClass?> = Observable(nil)
    
    func callWeatherAPi(for model: WeatherRequest) {
        NetworkManager.sharedInstance.fetchWaetherData(for: model, success: { [weak self] data in
            do{
                let response = try JSONDecoder().decode(CurrentWeatherModelClass.self, from: data)
                self?.weatherData.value = response
            } catch {
                print("Unable to parse")
            }
        }, failure: { [weak self] error in
        
        })
    }
    
    func callForecastAPi(for model: WeatherRequest) {
        NetworkManager.sharedInstance.fetchForecastData(for: model, success: { [weak self] data in
            do{
                let response = try JSONDecoder().decode(WeatherForecastModelClass.self, from: data)
                self?.ForecastData.value = response
                print(response.city?.name ?? "")
            } catch {
                print("Unable to parse")
            }
        }, failure: { [weak self] error in
            
        })
    }
}
