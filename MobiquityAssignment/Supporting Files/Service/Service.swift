//
//  Service.swift
//  MobiquityAssignment
//
//  Created by MAC on 16/08/21.
//

import UIKit


enum ApiEndPoint: String {
    case weatherForecast = "/2.5/weather"
}

struct ApiRouter {
    private let endPoint: ApiEndPoint
    private let params: [String: Any]
    
    init(endPoint: ApiEndPoint, params: [String: Any]) {
        self.endPoint = endPoint
        self.params = params
    }
    
    func asUrlRequest() -> URLRequest? {
        let urlStr = ApiConstant.baseUrl.rawValue + endPoint.rawValue
        var urlComponents = URLComponents(string: urlStr)
        var queryItems = [URLQueryItem(name: "appid", value: ApiConstant.apiKey.rawValue)]
        for param in params {
            let valStr: String
            if let val = param.value as? String {
                valStr = val
            } else {
                valStr = String(describing: param.value)
            }
            let queryItem = URLQueryItem(name: param.key, value: valStr)
            queryItems.append(queryItem)
        }
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else {return nil}
        print(url.absoluteString)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(ApiConstant.contentType.rawValue, forHTTPHeaderField: "Content-Type")
        return request
    }
}

class NetworkService {
    class func request(_ request: URLRequest, success:@escaping (Data) -> Void, failure:@escaping (Error) -> Void ) {
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            // Success block
            if let responseData = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                success(responseData)
                let responseString = String(data: responseData, encoding: .utf8)
                print("responseString = \(responseString!)")
            } else if let resonseError = error {
                    failure(resonseError)
            }
        }.resume()
    }
}
