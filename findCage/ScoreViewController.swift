//
//  ScoreViewController.swift
//  findCage
//
//  Created by Joffrey on 19/02/2016.
//  Copyright © 2016 Joffrey. All rights reserved.
//

import UIKit
import CoreData

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var scoreChronoLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var minute = 0
    var seconde = 0
    var milli = 0
    var name = "name"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Function for choice the message choosed in function of the chronometer score
        messageChoice()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // When the view appear we show the chronometer
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        scoreChronoLabel.text = String(format: "%02d:%02d:%02d", minute, seconde, milli)
    }
    
    // Function to choice message for user
    func messageChoice(){
        if minute <= 1{
            messageLabel.text = "Wow !  Nice Job !"
        }else if minute > 1 && minute < 3{
            messageLabel.text = "You can do better !"
        }else{
            messageLabel.text = "No, No, No, It's not good !"
        }
    }
    
    @IBAction func sendAction(sender: AnyObject) {
        
        // Get name of player for Hall of Fame
        name = nameTextField.text!
        
        if(name == ""){
            
            
        }else{
            
            // Declaration of Core Data object needed
            let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            let context:NSManagedObjectContext = appDel.managedObjectContext
            
            do{
                
                // Set Value for score and username in our core data database
                let newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
                newUser.setValue(scoreChronoLabel.text, forKey: "score")
                newUser.setValue(name, forKey: "username")
                
                // Add score and username in core data
                try context.save()
                print(newUser)
                print("Object Save")
                
                // Send user to view to HallOfFameViewController
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let instantiate = storyBoard.instantiateViewControllerWithIdentifier("HallOfFameViewController") as! HallOfFameViewController
                self.presentViewController(instantiate, animated:true, completion:nil)
                
            }catch{
                print(error)
            }
        }
    }
}
