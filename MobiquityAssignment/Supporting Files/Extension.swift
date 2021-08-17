//
//  Extension.swift
//  MobiquityAssignment
//
//  Created by MAC on 17/08/21.
//

import Foundation

extension UnitSpeed {
    static var metersPerMinute: UnitSpeed = .init(symbol: "m/min", converter:  UnitConverterLinear(coefficient: 1 / 60))
    static var kilometersPerMinute: UnitSpeed = .init(symbol: "km/min", converter:  UnitConverterLinear(coefficient: 50 / 3))
}
