//
//  NetworkManager.swift
//  MobiquityAssignment
//
//  Created by Akash Pal on 17/08/21.
//

import Foundation

class NetworkManager {
    class func fetchWaetherData(for model: WeatherRequest, success:@escaping (Data) -> Void, failure:@escaping (Error) -> Void ) {
        guard let params = model.dictionary else {return}
//                ["lat": lat, "long": long, "exclude": foreCastType.rawValue]
        let router = ApiRouter(endPoint: .weatherForecast, params: params)
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
