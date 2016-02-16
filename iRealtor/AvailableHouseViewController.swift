//
//  AvailableHouseViewController.swift
//  iRealtor
//
//  Created by Tuan Nguyen on 2/4/16.
//  Edited By Almore Cato II
//  Copyright (c) 2016 Tuan Nguyen. All rights reserved.
//

import UIKit
import CloudKit

class AvailableHouseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   // var houses: Array<CKRecord> = []
   // var houses: Array<House> = []

    let items: NSMutableArray = NSMutableArray()
      let houses: NSMutableArray = NSMutableArray()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchHouses()
        self.navigationController?.navigationBar.topItem?.title = "List Of All Available Houses"
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.frame = self.view.frame
        self.view.addSubview(tableView)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.houses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        var hid: House = houses[indexPath.row] as! House
        cell.textLabel?.text = String(hid.HouseID)
        //cell.textLabel?.text = hid.locationToName()

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchHouses() {
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "HOUSE", predicate: predicate)
        
        publicDatabase.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            if error != nil {
                println(error)
            }
            else {
                
                for result in results {
                    let tr:CKRecord = result as! CKRecord
                    var testID:Int = tr.valueForKey("HouseID") as! Int
                    var testPrice:Int = tr.valueForKey("Price") as! Int
                    var testBeds:Int = tr.valueForKey("Bedrooms") as! Int
                    var testBaths:Int = tr.valueForKey("Bathrooms") as! Int
                    var testSold:Int = tr.valueForKey("Sold") as! Int
                    var imageAsset: Array<CKAsset> = tr.valueForKey("Photos") as! Array<CKAsset>

                    //var testImage: UIImage = UIImage(contentsOfFile: imageAsset[0].fileURL.path!)!
                    
                    //imageAsset = tr.valueForKey("Photo") as! NSMutableArray
                    var testLocation:CLLocation = tr.valueForKey("Location") as! CLLocation
                   var testHouse: House = House(HouseID: testID, Price: testPrice, Location: testLocation, Bedrooms: testBeds, Bathrooms: testBaths , Sold: testSold, Photo: imageAsset)
                    self.houses.addObject(testHouse)
                    println("House")
                    println(testHouse.HouseID)
                    println(testHouse.Location)
                    println(testHouse.Price)
                    println(testHouse.Bedrooms)
                    println(testHouse.Bathrooms)
                    println(testHouse.Sold)

                }
                
                    println(self.houses.count)
                
            
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tableView.reloadData()
                    self.tableView.hidden = false
                })
                
                
                
            }
        }
    }
    
    func writeRecord() {
        let database = CKContainer.defaultContainer().publicCloudDatabase
        var record = CKRecord(recordType: "HOUSE")
        record.setObject(4, forKey: "Bathrooms")
        record.setObject(3, forKey: "Bedrooms")
        record.setObject(1234, forKey: "HouseID")
        record.setObject(300000, forKey: "Price")
        record.setObject(0, forKey: "Sold")
        database.saveRecord(record, completionHandler: { (savedRecord, saveError) in
            if saveError != nil {
                println("Error saving record: \(saveError.localizedDescription)")
            } else {
                println("Successfully saved record!")
            }
        })
    }
    
    private func fetchUserRecord(recordID: CKRecordID) {
        // Fetch Default Container
        let defaultContainer = CKContainer.defaultContainer()
//        print(house)
        
        // Fetch Private Database
        let privateDatabase = defaultContainer.privateCloudDatabase
        
        // Fetch User Record
        privateDatabase.fetchRecordWithID(recordID) { (record, error) -> Void in
            if let responseError = error {
                print(responseError)
                
            } else if let userRecord = record {
                print(userRecord)
            }
        }
    }
}
//
