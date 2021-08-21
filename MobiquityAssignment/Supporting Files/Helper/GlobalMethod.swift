//
//  GlobalMethod.swift
//  MobiquityAssignment
//
//  Created by MAC on 17/08/21.
//

import UIKit

class GlobalMethod: NSObject {
    
    static let sharedInstance = GlobalMethod()
    
    func getSpeedKilometersPerHour(spped: Double) -> String{
        let metersPerSecond = Measurement<UnitSpeed>(value: spped, unit: .metersPerSecond)
        let kilometersPerHour = metersPerSecond.converted(to: .kilometersPerHour)      //
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .medium
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 1
        formatter.string(from: kilometersPerHour)      // "108 km/h"
        return "\(formatter.string(from: kilometersPerHour))"
    }
    
    func dateTimeChangeFormat(str stringWithDate: String, inDateFormat: String, outDateFormat: String) -> String {
        let inFormatter = DateFormatter()
        inFormatter.locale = Locale(identifier: "en_US_POSIX")
        inFormatter.dateFormat = inDateFormat

        let outFormatter = DateFormatter()
        outFormatter.locale = Locale(identifier: "en_US_POSIX")
        outFormatter.dateFormat = outDateFormat

        let inStr = stringWithDate
        let date = inFormatter.date(from: inStr)!
        return outFormatter.string(from: date)
    }
}


