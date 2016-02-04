//
//  AvailableHouseViewController.swift
//  iRealtor
//
//  Created by Tuan Nguyen on 2/4/16.
//  Edited by Almore Cato II
//  Copyright (c) 2016 Tuan Nguyen. All rights reserved.
//

import UIKit
import CloudKit

class AvailableHouseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var houses: Array<CKRecord> = []
    var items: Array<String> = ["House1", "House2", "House3"]

    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "List Of All Available Houses"
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.frame = self.view.frame
        self.view.addSubview(tableView)
        fetchHouses()
        
         println(houses.count)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell.textLabel?.text = self.items[indexPath.row]
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
                println(results)
                
                for result in results {
                    self.houses.append(result as! CKRecord)
                }
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tableView.reloadData()
                    self.tableView.hidden = false
                })
            }
        }
    }
}
