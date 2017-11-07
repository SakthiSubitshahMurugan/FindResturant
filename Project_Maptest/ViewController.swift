//
//  ViewController.swift
//  Project_Maptest
//
//  Created by Sakhti Subitshah Murugan on 9/7/17.
//  Copyright © 2017 Sakhti Subitshah Murugan. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,MKMapViewDelegate{
    @IBOutlet weak var mapview: MKMapView!
   
    var zipCode=zipcode
    var searchItem=SearchValue
    
    
    @IBOutlet weak var tableView: UITableView!
    var Title = [String]()
    var Latitude = [String]()
    var Longitude = [String]()
    var Address = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        mapview.delegate=self
    //    NotificationCenter.default.addObserver(self, selector: #selector(ViewController.Display), name: //NSNotification.Name(rawValue:notification_key), object: nil)
        
        parsedata()
        for i in stride(from: 0, to: Latitude.count, by: 1){
            //var i=Int(i)
            let coordinate = CLLocationCoordinate2DMake(Double(Latitude[i])!, Double(Longitude[i])!)
            let span = MKCoordinateSpan.init(latitudeDelta: 0.2, longitudeDelta: 0.2)
            let coordinateRegion = MKCoordinateRegion.init(center: coordinate, span: span)
            mapview.setRegion(coordinateRegion, animated: true)
            let annotation = MKPointAnnotation()
            annotation.title=Title[i]
            annotation.subtitle=Address[i]
            annotation.coordinate=coordinate
            mapview.addAnnotation(annotation)
           // print(i)
         
        }
    //    @objc func Display(){
     //       notif
    //        self.zipCode = zipcode
    //        self.searchItem =
    //    }
        
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return Title.count
        
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"Cell1", for: indexPath)
        cell.textLabel?.text=Title[indexPath.row]
        return cell
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
            if let annotationView = mapview.dequeueReusableAnnotationView(withIdentifier: "pin") {
                annotationView.annotation = annotation
                return annotationView
            } else {
               // print("*************")
                let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:"pin")
                annotationView.isEnabled = true
                annotationView.canShowCallout = true
                
                let btn = UIButton(type: .detailDisclosure)
                annotationView.rightCalloutAccessoryView = btn
                return annotationView
            }
        }
       
    
 
    
    func parsedata(){
        let urlString = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20local.search%20where%20zip=%27"+zipCode+"%27%20and%20query%20=%20%27"+searchItem+"%27%20&format=json&callback="
        //print(urlString)

        //print(urlString)
        let url = URL.init(string: urlString)
        do{
            let response = try Data.init(contentsOf: url!)
         
            let parsedresponse = try JSONSerialization.jsonObject(with: response, options: []) as! [String:Any]
           // print(parsedresponse)
            let data1 = parsedresponse["query"] as! [String:Any]
            let results=data1["results"] as! [String:Any]
            let Result=results["Result"] as! [[String:Any]]
            for temp in Result{
                //var data4 = (temp["Title"] as! String)
                Title.append(temp["Title"] as! String)
                Latitude.append(temp["Latitude"] as! String)
                Longitude.append(temp["Longitude"] as! String)
                Address.append (temp["Address"] as! String)
            }
           
 
     
       
        }catch let error{
            
        }
    
    
    }
  
    

}

