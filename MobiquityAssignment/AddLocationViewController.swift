//
//  ViewController.swift
//  MobiquityAssignment
//
//  Created by MAC on 16/08/21.
//
import CoreLocation
import MapKit
import UIKit

class AddLocationViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    let manager = CLLocationManager()
    var pin = MKPointAnnotation()
    let geocoder = CLGeocoder()

    var selectedAddress = String()
    var selectedLatitude = String()
    var selectedLongitude = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addWaypoint(tapGesture:)))
        self.mapView.addGestureRecognizer(tapGesture)
        self.configureMap()
        // Do any additional setup after loading the view.
    }

    func configureMap(){
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    //MARK:  Add Annotation On Mapview  
    @objc func addWaypoint(tapGesture: UIGestureRecognizer) {

        let touchPoint = tapGesture.location(in: mapView)
        let wayCoords = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let coordinate = CLLocationCoordinate2D(latitude: wayCoords.latitude, longitude: wayCoords.longitude)
        pin.coordinate = coordinate
        self.mapView.addAnnotation(pin)
        let location = CLLocation(latitude: wayCoords.latitude, longitude: wayCoords.longitude)
        self.fetchAddress(location: location)
        
        self.selectedLatitude = "\(location.coordinate.latitude)"
        self.selectedLongitude = "\(location.coordinate.longitude)"
    }
    
    //MARK:  Done Button action  
    
    @IBAction func doneButtonAction(_ sender: Any) {
        let dict: [String:String] = ["address":self.selectedAddress,"latitude":self.selectedLatitude,"longitude":self.selectedLongitude]
        print(dict)
        DatabaseHelper.shareInstance.save(object: dict) { isSave in
            if isSave{
                GlobalMethod.sharedInstance.alertMessage(title: messageConstant.alert.rawValue, message: messageConstant.saveMsg.rawValue, firstButtonTitle: messageConstant.okay.rawValue) { tag in
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                GlobalMethod.sharedInstance.alertMessage(title: messageConstant.error.rawValue, message: messageConstant.notSave.rawValue, firstButtonTitle: messageConstant.okay.rawValue) { tag in
                    
                }
            }
        }
    }
    
    //MARK:  Map view render  
    
    func render(_ location:CLLocation){
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.mapView.setRegion(region, animated: true)
        
        // Add markar
        pin.coordinate = coordinate
        self.mapView.addAnnotation(pin)
    }
    
    //MARK:  Fetch Address fUsing Reverse Geocode 
    
    func fetchAddress(location:CLLocation){
        geocoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error) in
                if (error != nil) {
                    print("Error in reverseGeocode")
                    }

                let placemark = placemarks! as [CLPlacemark]
                if placemark.count > 0 {
                    let placemark = placemarks![0]
                    self.selectedAddress = "\(placemark.subLocality ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.country ?? "")"
                }
            })
    }
    
}

extension AddLocationViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            manager.stopUpdatingLocation()
            self.render(location)
            self.fetchAddress(location: location)
            self.selectedLatitude = "\(location.coordinate.latitude)"
            self.selectedLongitude = "\(location.coordinate.longitude)"
        }
    }
}
