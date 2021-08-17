//
//  HomeViewModel.swift
//  MobiquityAssignment
//
//  Created by Akash Pal on 16/08/21.
//

import Foundation

class HomeViewModel {
    weak var homeVC: HomeViewController?
    var addressArray: [Location]? 
    
    func fetchDataFromDB() -> [Location] {
        self.addressArray = DatabaseHelper.shareInstance.getLocationData()
        return self.addressArray ?? []
    }
}
