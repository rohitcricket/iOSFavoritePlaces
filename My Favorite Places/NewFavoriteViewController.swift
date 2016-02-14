//
//  NewFavoriteViewController.swift
//  My Favorite Places
//
//  Created by ROHIT GUPTA on 2/13/16.
//  Copyright © 2016 ROHIT GUPTA. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class NewFavoriteViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var map: MKMapView!
    
    var locationManager : CLLocationManager?
    
    var firstTime : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.map.showsUserLocation = true
        
        self.locationManager = CLLocationManager()
        self.locationManager?.requestWhenInUseAuthorization()
        self.locationManager?.delegate = self
        self.locationManager?.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if self.firstTime == true {
        let region = MKCoordinateRegionMakeWithDistance(self.locationManager!.location!.coordinate, 10000, 10000)
        self.map.setRegion(region, animated: false)
        self.firstTime = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func doneTapped(sender: AnyObject) {
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let favorite1 = NSEntityDescription.insertNewObjectForEntityForName("Favorite", inManagedObjectContext: context) as! Favorite
        
        favorite1.name = self.textField.text
        favorite1.latitude = self.map.region.center.latitude
        favorite1.longitude = self.map.region.center.longitude
        favorite1.latitudeDelta = self.map.region.span.latitudeDelta
        favorite1.longitudeDelta = self.map.region.span.longitudeDelta
        
        do {
            try context.save()
        } catch {
            print("Error! Did not save name.")
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}
