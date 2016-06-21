//
//  HallOfFameViewController.swift
//  findCage
//
//  Created by Joffrey on 19/02/2016.
//  Copyright © 2016 Joffrey. All rights reserved.
//

import UIKit
import CoreData

class HallOfFameViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var HOFTableView: UITableView!
    
    let lineTableView = 10
    
    var usernameArray:[String] = []
    var scoreArray:[String] = []
    
    // Say what's the maximum of cell in the table view
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (usernameArray.count > 10){
            return lineTableView
        }else{
            return usernameArray.count
        }
    }
    
    // Add informations for each cell in the table view following the prototype
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = HOFTableView.dequeueReusableCellWithIdentifier("prototype", forIndexPath: indexPath)
        
        cell.textLabel?.text =  usernameArray[indexPath.row]
        cell.detailTextLabel?.text = scoreArray[indexPath.row]
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        HOFTableView.dataSource = self
        
        do{
            let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            let context:NSManagedObjectContext = appDel.managedObjectContext
            
            let request = NSFetchRequest(entityName: "Users")
            request.returnsObjectsAsFaults = false
            
            let list:NSArray = try context.executeFetchRequest(request)
            //jean = list.count
            
            if(list.count > 0){
                
                for var i = 0; i < list.count; ++i {
                    // Add username and score in the array for the table view
                    usernameArray.append(list[i].valueForKey("username") as! String)
                    scoreArray.append(list[i].valueForKey("score") as! String)
                    
                }
            }else{
                print("No result")
            }
        } catch let error as NSError {
            // If, there is an error I print the error
            print("Fetch failed: \(error.localizedDescription)")
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}