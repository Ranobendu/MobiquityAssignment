//
//  MobiquityAssignmentTests.swift
//  MobiquityAssignmentTests
//
//  Created by MAC on 16/08/21.
//

import XCTest
@testable import MobiquityAssignment
import CoreData

class MobiquityAssignmentTests: XCTestCase {
    
    let apiClient = MockOpenWeatherMapApiClient()
    
    override func setUp() {
        
    }
    
    func test_api_for_weather() throws {
        let  requst = WeatherRequest(latitude: 19.04866902157453, longitude: 19.04866902157453, forecastType: .hourly)
        apiClient.fetchWaetherData(for: requst) { (responce) in
            XCTAssertTrue(responce.count > 0)
        } failure: { (eror) in
            XCTAssertFalse(false)
        }
    }

    func test_api_for_Forecast() throws {
      let  requst = WeatherRequest(latitude: 19.04866902157453, longitude: 19.04866902157453, forecastType: .daily)
        apiClient.fetchForecastData(for: requst) { (responce) in
            XCTAssertTrue(responce.count > 0)
        } failure: { (eror) in
            XCTAssertFalse(false)
        }
    }
    
    func test_add_address_usingcoredata() throws {
      let data = ["address":"1 Abc Street","latitude": "34550.0","longitude":"234250.0"]
        
        DatabaseHelper.shareInstance.save(object: data)
        let getLocation =  DatabaseHelper.shareInstance.getLastData("1 Abc Street")
        XCTAssertEqual("1 Abc Street", getLocation?.address)
        
    }
    
    func test_delete_address_usingcoredata() throws {
        let address1 = ["address":"1 Abc Street","latitude": "34550.0","longitude":"234250.0"]
        let address2 = ["address":"2 Abc Street","latitude": "34550.0","longitude":"234250.0"]
        let address3 = ["address":"3 Abc Street","latitude": "34550.0","longitude":"234250.0"]
        
        
        DatabaseHelper.shareInstance.save(object: address1)
        DatabaseHelper.shareInstance.save(object: address2)
        DatabaseHelper.shareInstance.save(object: address3)
        
        let fetchAddress1 = DatabaseHelper.shareInstance.getLastData("1 Abc Street")
        let fetchAddress2 = DatabaseHelper.shareInstance.getLastData("2 Abc Street")
        let fetchAddress3 = DatabaseHelper.shareInstance.getLastData("3 Abc Street")
        
        let addressList = DatabaseHelper.shareInstance.deleteData(getLocation: fetchAddress2!)
        XCTAssertEqual(addressList?.count, 2)
        XCTAssertTrue(((addressList?.contains(fetchAddress1!)) != nil))
        XCTAssertTrue(((addressList?.contains(fetchAddress3!)) != nil))
    }

    func test_date_time_changeFormat() throws {
        let getDate = GlobalMethod.sharedInstance.dateTimeChangeFormat(str: "2021-08-21 12:00:00", inDateFormat: "yyyy-MM-dd HH:mm:ss", outDateFormat: "MMM d, h:mm a")
        XCTAssertEqual("Aug 21, 12:00 PM", getDate)
    }
    
    func test_get_Speed_Kilometers_PerHour() throws {
        let getDate = GlobalMethod.sharedInstance.getSpeedKilometersPerHour(spped: 10.06)
        XCTAssertEqual("36.2 km/h", getDate)
    }
}
