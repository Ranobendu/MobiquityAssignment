//
//  MockApiClient.swift
//  MobiquityAssignmentTests
//
//  Created by MAC on 20/08/21.
//

import Foundation
@testable import MobiquityAssignment

class MockOpenWeatherMapApiClient {
    
    
    var shouldReturnError = false
    var weatherApiCalled = false
    var forecastApiWasCalled = false
    
    enum MockServiceError {
        case weatherApi
        case forecastApi
    }
    
    func reset() {
        shouldReturnError = false
        weatherApiCalled = false
        forecastApiWasCalled = false
    }
    
    convenience init() {
        self.init(false)
    }
    
    init(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    let mockWeatherResponse: [String: Any] = [
        "coord":[
        "lon":19.0617,
        "lat":19.0617
        ],
        "weather":[
        [
        "id":802,
        "main":"Clouds",
        "description":"scattered clouds",
        "icon":"03d"
        ]
        ],
        "base":"stations",
        "main":[
        "temp":303.61,
        "feels_like":301.71,
        "temp_min":303.61,
        "temp_max":303.61,
        "pressure":1011,
        "humidity":18,
        "sea_level":1011,
        "grnd_level":946
        ],
        "visibility":10000,
        "wind":[
        "speed":11.16,
        "deg":25,
        "gust":14.97
        ],
        "clouds":[
        "all":33
        ],
        "dt":1629525995,
        "sys":[
        "country":"TD",
        "sunrise":1629519992,
        "sunset":1629565657
        ],
        "timezone":3600,
        "id":7602866,
        "name":"Borkou Region",
        "cod":200
        ]
    
    let mockForecastResponse: [String: Any] = ["cod":"200","message":0,"cnt":40,"list":[["dt":1629957600,"main":["temp":305.27,"feels_like":303.19,"temp_min":305.27,"temp_max":305.27,"pressure":1009,"sea_level":1009,"grnd_level":945,"humidity":19,"temp_kf":0],"weather":[["id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"]],"clouds":["all":39],"wind":["speed":10.87,"deg":25,"gust":13.38],"visibility":10000,"pop":0,"sys":["pod":"d"],"dt_txt":"2021-08-26 06:00:00"]],"city":["id":7602866,"name":"Borkou Region","coord":["lat":19.0617,"lon":19.0617],"country":"TD","population":0,"timezone":3600,"sunrise":1629519992,"sunset":1629565657]]
}

extension MockOpenWeatherMapApiClient: APIServiceProtocol {
   
    func fetchWaetherData(for model: WeatherRequest, success:@escaping (Data) -> Void, failure:@escaping (Error) -> Void ) {
        weatherApiCalled = true
        if shouldReturnError {
            failure(MockServiceError.weatherApi as! Error)
        } else {
            let jsonData = try! JSONSerialization.data(withJSONObject: mockWeatherResponse, options: JSONSerialization.WritingOptions.prettyPrinted)
                success(jsonData)
        }
    }
    
    func fetchForecastData(for model: WeatherRequest, success:@escaping (Data) -> Void, failure:@escaping (Error) -> Void ) {
        forecastApiWasCalled = true
        if shouldReturnError {
            failure(MockServiceError.weatherApi as! Error)
        } else {
            let jsonData = try! JSONSerialization.data(withJSONObject: mockForecastResponse, options: JSONSerialization.WritingOptions.prettyPrinted)
                success(jsonData)
        }
    }



}
