//
//  NetworkManager.swift
//  MobiquityAssignment
//
//  Created by Akash Pal on 17/08/21.
//

import Foundation


protocol APIServiceProtocol {
    func fetchWaetherData(for model: WeatherRequest, success:@escaping (Data) -> Void, failure:@escaping (Error) -> Void )
    
    func fetchForecastData(for model: WeatherRequest, success:@escaping (Data) -> Void, failure:@escaping (Error) -> Void )
    
}
class NetworkManager: APIServiceProtocol {
    
    static let sharedInstance = NetworkManager()
    
    func fetchWaetherData(for model: WeatherRequest, success:@escaping (Data) -> Void, failure:@escaping (Error) -> Void ) {
        guard let params = model.dictionary else {return}
        let router = ApiRouter(endPoint: .weather, params: params)
        guard let request = router.asUrlRequest() else {return}
        NetworkService.request(request, success: success, failure: failure)
    }
    
    func fetchForecastData(for model: WeatherRequest, success:@escaping (Data) -> Void, failure:@escaping (Error) -> Void ) {
        guard let params = model.dictionary else {return}
        let router = ApiRouter(endPoint: .forecast, params: params)
        guard let request = router.asUrlRequest() else {return}
        NetworkService.request(request, success: success, failure: failure)
    }
}


extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}
