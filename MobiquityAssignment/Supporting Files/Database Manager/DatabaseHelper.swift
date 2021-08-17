//
//  DatabaseHelper.swift
//  MobiquityAssignment
//
//  Created by MAC on 16/08/21.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    
    static var shareInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func save(object:[String:String]){
        let location = NSEntityDescription.insertNewObject(forEntityName: "Location", into: context!) as! Location
        location.address = object["address"]
        location.latitude = object["latitude"]
        location.longitude = object["longitude"]
        do {
            try context?.save()
        } catch {
            print("data is not save")
        }
    }
    
    func getLocationData() -> [Location]{
        var location = [Location]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Location")
        do {
            location = try context?.fetch(fetchRequest) as! [Location]
        } catch {
            print("can not get data")
        }
        return location
    }
    
    func deleteData(index:Int) -> [Location]{
        var location = getLocationData()
        context?.delete(location[index])
        location.remove(at: index)
        do {
            try context?.save()
        } catch {
            print("can not delete data")
        }
        return location
    }
}
