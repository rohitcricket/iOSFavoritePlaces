//
//  ViewController.swift
//  My Favorite Places
//
//  Created by ROHIT GUPTA on 2/12/16.
//  Copyright © 2016 ROHIT GUPTA. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var favorites : [Favorite] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
       // createTestFavoritePlace()
    }
    
    override func viewWillAppear(animated: Bool) {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let request = NSFetchRequest(entityName: "Favorite")
        
        var results : [AnyObject]?
        
        do {
            try results = context.executeFetchRequest(request)
        } catch {
            results = nil
        }
        
        if results != nil {
            self.favorites = results as! [Favorite]
        }
        
        self.tableView.reloadData()
        
    }

    func createTestFavoritePlace(){
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let favorite1 = NSEntityDescription.insertNewObjectForEntityForName("Favorite", inManagedObjectContext: context) as! Favorite
        
        favorite1.name = "Santa Barbara"
        favorite1.latitude = 34.420831
        favorite1.longitude = -119.698190
        favorite1.latitudeDelta = 3
        favorite1.longitudeDelta = 3
        
        do {
            try context.save()
        } catch {
            print("Error! Did not save name.")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favorites.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("mapCell") as! MapTableViewCell
        let favorite = self.favorites[indexPath.row]
        cell.favoriteNameLabel.text = favorite.name
        
        let coordinate = CLLocationCoordinate2DMake(favorite.latitude!.doubleValue, favorite.longitude!.doubleValue)
        
        let span = MKCoordinateSpanMake(favorite.latitudeDelta!.doubleValue, favorite.longitudeDelta!.doubleValue)
        
        let region = MKCoordinateRegionMake(coordinate, span)
        
        cell.favoriteMapView.setRegion(region, animated: false)
        
        return cell
    }

}

