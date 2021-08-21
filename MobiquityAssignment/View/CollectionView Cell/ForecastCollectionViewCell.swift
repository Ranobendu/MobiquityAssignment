//
//  ForecastCollectionViewCell.swift
//  MobiquityAssignment
//
//  Created by MAC on 19/08/21.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblData: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblWeather: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    
    var forecastData: List!{
        didSet{
        
            let kelvinTemp = forecastData.main?.temp ?? 0
            lblTemperature.text = "\(Int(kelvinTemp - 273.15))°C"
            lblData.text = GlobalMethod.sharedInstance.dateTimeChangeFormat(str: forecastData.dtTxt ?? "",
            inDateFormat:  "yyyy-MM-dd HH:mm:ss",
            outDateFormat: "MMM d, h:mm a")
            lblHumidity.text = "Humidity :\(forecastData?.main?.humidity ?? 00)%"
            lblWeather.text = "Weather : \(forecastData?.weather?[0].weatherDescription ?? "")"
            lblWind.text = "Wind : \(GlobalMethod.sharedInstance.getSpeedKilometersPerHour(spped: forecastData?.wind?.speed ?? 0.0))"
        }
    }
    
}
