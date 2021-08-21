//
//  Enum.swift
//  MobiquityAssignment
//
//  Created by Akash Pal on 17/08/21.
//

import Foundation

enum ApiConstant: String {
    case baseUrl = "https://api.openweathermap.org/data/2.5/"
    case apiKey = "258b5528175c3cd60e5a3c358423bacb"
    case contentType = "Application/json"
}
 
enum ForeCastType: String, Codable {
    case hourly = "hourly"
    case daily = "daily"
}
