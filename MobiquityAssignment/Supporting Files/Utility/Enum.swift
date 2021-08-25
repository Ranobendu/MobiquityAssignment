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

enum messageConstant: String {
    case saveMsg = "Address saved successfully"
    case notSave = "Address not save"
    case deleteMsg = "Address delete successfully"
    case notDeleteMsg = "Address can not delete"
    case deleteCheckMsg = "do you want to delete your this address?"
    case okay = "Okay"
    case alert = "Alert"
    case delete = "Delete"
    case cancel = "Cancel"
    case error = "Error"
}
