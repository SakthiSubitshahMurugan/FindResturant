//
//  SecondViewController.swift
//  Project_Maptest
//
//  Created by Sakhti Subitshah Murugan on 9/7/17.
//  Copyright © 2017 Sakhti Subitshah Murugan. All rights reserved.
//

import UIKit
import CoreLocation

var zipcode=""
var SearchValue=""
class SecondViewController: UIViewController,CLLocationManagerDelegate{
    
    @IBAction func Update(_ sender: Any) {
        locationManager.startUpdatingLocation()
    }
    
    @IBOutlet weak var Search: UITextField!
    
    @IBOutlet weak var zipText: UITextField!
    
    var location : CLLocation!{
        didSet{
         //   Search.text = "\(location.coordinate.latitude)"
         //   zipText.text="\(location.coordinate.longitude)"
            
        }
    }
    
    var locationManager:CLLocationManager!
    
    @IBAction func searchTextbtn(_ sender: UIButton) {
        zipcode = zipText.text!
        SearchValue = Search.text!
        performSegue(withIdentifier: "Segue1", sender: self)
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
        
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Segue1" {
            let controller = segue.destination as! ViewController
            controller.zipCode = zipcode as! String
            controller.searchItem=SearchValue as! String
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager=CLLocationManager()
        locationManager.delegate=self
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
        checkCoreLocationPermission()
    }
    func checkCoreLocationPermission(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            locationManager.startUpdatingLocation()
            
        }else if CLLocationManager.authorizationStatus() == .notDetermined{
            locationManager.requestWhenInUseAuthorization()
            
        }else if CLLocationManager.authorizationStatus() == .restricted{
            print("unahorized to use location service")
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = (locations as! [CLLocation]).last
        locationManager.startUpdatingLocation()
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if error != nil
            {
                print("There is a Error")
            }else{
                if let place = placemark?[0]{
                    self.zipText.text = place.postalCode
                }
            }
        }
    }
//    CLGeocoder().reverseGeocodeLocation(location){(placemark,error) in
    

}
