//
//  NormalViewController.swift
//  findCage
//
//  Created by Joffrey on 11/02/2016.
//  Copyright © 2016 Joffrey. All rights reserved.
//

import UIKit

class NormalViewController : UIViewController, UIScrollViewDelegate
{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var chronoLabel: UILabel!
    
    
    var timer = NSTimer()
    var counter = 2
    
    var chrono = NSTimer()
    var counterMs = 0
    var counterSec = 0
    var counterMin = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Hide Win Label
        winLabel.hidden = true
        winLabel.text = "You Win !"
        
        // Hide Time Label
        timeLabel.hidden = true
        
        // Parameters for the zoom
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
        
        // Add Gesture Recognizer on the image view
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapImage:"))
        
        // Chrono go
        if chrono.valid == false {
            chrono = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateChrono"), userInfo: nil, repeats: true)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Zoom Function
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        return self.imageView
        
    }
    
    // Function that define if user win or not
    func tapImage(gesture: UIGestureRecognizer){
        
        // Get coordinate of tap gesture
        let point = gesture.locationInView(gesture.view)
        
        // Only used for debug
        //print(point)
        
        if point.x >= 225 && point.x <= 250 && point.y >= 205 && point.y <= 230
        {
            // Show Win Label
            winLabel.hidden = false
            
            // Stop chrono
            stopChrono()
            
            // Show Score View
            goToScoreView()
            
        }
        else
        {
            // if it's not the good coordinate we block gesture
            imageView.userInteractionEnabled = false
            imageView.removeGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapImage:"))
            
            counter = 2
            winLabel.hidden = true
            timeLabel.hidden = false
            
            // The 2 seconds timer
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerAction", userInfo: nil, repeats: true)
            //print(timer.userInfo as? String)
            
            // Reactivation of gesture
            if(timerAction() == 0){
                print("0")
                print("invalidate")
                timer.invalidate()
                
                imageView.userInteractionEnabled = true
                imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapImage:"))
                
            }
        }
    }
    
    
    func timerAction() -> Int{
        var count = counter--
        //print(count)
        
        timeLabel.text = String(count)
        
        if(count == 0){
            
            // Stop the timer
            timer.invalidate()
            // Hide the time label
            timeLabel.hidden = true
            
            imageView.userInteractionEnabled = true
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapImage:"))
            
        }
        return count
    }
    
    // Function needed for chronometer
    func updateChrono(){
        if counterMs == 99{
            counterMs = 0
            counterSec++
        }else if(counterSec == 60){
            counterSec = 0
            counterMin++
        }else{
            counterMs++
        }
        chronoLabel.text = String(format: "%02d:%02d:%02d", counterMin,counterSec, counterMs)
    }
    
    func stopChrono(){
        chrono.invalidate()
    }
    
    // Function say which value is send
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "ShowScoreSegue" {
            if let destinationVC = segue.destinationViewController as? ScoreViewController{
                //destinationVC.score = String(format: "%02d:%02d:%02d", counterMin, counterSec, counterMs)
                destinationVC.minute = counterMin
                destinationVC.seconde = counterSec
                destinationVC.milli = counterMs
            }
        }
    }
    
    // Go to result view : ScoreViewController
    func goToScoreView(){
        performSegueWithIdentifier("ShowScoreSegue", sender: self)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("ScoreViewController") as! ScoreViewController
        self.presentViewController(resultViewController, animated:true, completion:nil)
    }
}
