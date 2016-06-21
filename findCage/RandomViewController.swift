//
//  RandomViewController.swift
//  findCage
//
//  Created by Joffrey on 19/02/2016.
//  Copyright © 2016 Joffrey. All rights reserved.
//

import UIKit

class RandomViewController : UIViewController, UIScrollViewDelegate
{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var chronoLabel: UILabel!
    
    var randomValue = 0
    
    // Timer for no spam
    var timer = NSTimer()
    var counter = 2
    
    // Timer for chronometer
    var chrono = NSTimer()
    var counterMs = 0
    var counterSec = 0
    var counterMin = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        changeBackground()
        imageView.contentMode = .Redraw
        
        
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
        addGesture()
        
        // Active Chrono
        if chrono.valid == false {
            chrono = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateChrono"), userInfo: nil, repeats: true)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Attribution of Zoom for the imageView
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        return self.imageView
        
    }
    
    // Add gesture recognizer for the imageView
    func addGesture(){
        
        if (randomValue == 1){
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapImageRandom1:"))
        }else if(randomValue == 2){
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapImageRandom2:"))
        }else{
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapImageRandom3:"))
        }
    }
    
    // Determination if player win or not
    func tapImageRandom1(gesture: UIGestureRecognizer){
        
        let point = gesture.locationInView(gesture.view)
        print(point)
        
        if point.x >= 238 && point.x <= 247 && point.y >= 114 && point.y <= 122
        {
            // Show Win Label
            winLabel.hidden = false
            
            // Stop chrono
            stopChrono()
            
            goToScoreView()
            
        }
        else
        {
            imageView.userInteractionEnabled = false
            imageView.removeGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapImageRandom1:"))
            
            counter = 2
            winLabel.hidden = true
            timeLabel.hidden = false
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerAction", userInfo: nil, repeats: true)
            print(timer.userInfo as? String)
            
            if(timerAction() == 0){
                print("0")
                print("invalidate")
                timer.invalidate()
                
                imageView.userInteractionEnabled = true
                imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapImageRandom1:"))
                
            }
        }
    }
    
    func tapImageRandom2(gesture: UIGestureRecognizer){
        
        let point = gesture.locationInView(gesture.view)
        print(point)
        
        if point.x >= 628 && point.x <= 652 && point.y >= 120 && point.y <= 136
        {
            // Show Win Label
            winLabel.hidden = false
            
            // Stop chrono
            stopChrono()
            
            goToScoreView()
            
        }
        else
        {
            imageView.userInteractionEnabled = false
            imageView.removeGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapImageRandom2:"))
            
            counter = 2
            winLabel.hidden = true
            timeLabel.hidden = false
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerAction", userInfo: nil, repeats: true)
            print(timer.userInfo as? String)
            
            if(timerAction() == 0){
                print("0")
                print("invalidate")
                timer.invalidate()
                
                imageView.userInteractionEnabled = true
                imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapImageRandom2:"))
                
            }
        }
    }
    
    func tapImageRandom3(gesture: UIGestureRecognizer){
        
        let point = gesture.locationInView(gesture.view)
        print(point)
        
        if point.x >= 465.0 && point.x <= 485.0 && point.y >= 212 && point.y <= 234
        {
            // Show Win Label
            winLabel.hidden = false
            
            // Stop chrono
            stopChrono()
            
            goToScoreView()
            
        }
        else
        {
            imageView.userInteractionEnabled = false
            imageView.removeGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapImageRandom3:"))
            
            counter = 2
            winLabel.hidden = true
            timeLabel.hidden = false
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerAction", userInfo: nil, repeats: true)
            print(timer.userInfo as? String)
            
            if(timerAction() == 0){
                print("0")
                print("invalidate")
                timer.invalidate()
                
                imageView.userInteractionEnabled = true
                imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapImageRandom3:"))
                
            }
        }
    }
    
    func timerAction() -> Int{
        var count = counter--
        print(count)
        
        timeLabel.text = String(count)
        
        if(count == 0){
            
            // Stop the timer
            timer.invalidate()
            
            // Hide the time label
            timeLabel.hidden = true
            
            imageView.userInteractionEnabled = true
            
            if (randomValue == 1){
                imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapImageRandom1:"))
            }else if(randomValue == 2){
                imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapImageRandom2:"))
            }else{
                imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapImageRandom3:"))
            }
            
        }
        return count
    }
    
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
    
    func random()-> Int{
        let number = Int(arc4random_uniform(3) + 1)
        print(number)
        return number
    }
    // Choose the image for the random number
    func changeBackground(){
        
        randomValue = random()
        //print("random \(randomValue)")
        
        switch randomValue{
        case 1: imageView.image = UIImage(named: "1.jpg")
        case 2: imageView.image = UIImage(named: "2.jpg")
        case 3: imageView.image = UIImage(named: "3.jpg")
        default: break
        }
    }
    
    // Function say which value is send
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "RandomSegue" {
            if let destinationVC = segue.destinationViewController as? ScoreViewController{
                destinationVC.minute = counterMin
                destinationVC.seconde = counterSec
                destinationVC.milli = counterMs
            }
        }
    }
    
    func goToScoreView(){
        // Go to result view -> ScoreViewController
        performSegueWithIdentifier("RandomSegue", sender: self)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("ScoreViewController") as! ScoreViewController
        self.presentViewController(resultViewController, animated:true, completion:nil)
    }
    
}
