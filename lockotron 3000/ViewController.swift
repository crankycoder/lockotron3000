//
//  ViewController.swift
//  lockotron 3000
//
//  Created by Victor Ng on 2015-03-15.
//  Copyright (c) 2015 crankycoder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    
    @IBOutlet var myLabel: UILabel!
    
    
    @IBOutlet var myBumpDetector: UILabel!
    
    let motionKit = MotionKit()
    var swichatron4000 = false
    
    var bumpStart = false
    var bumpEnd = false

    var bumpcount = 0
    
    @IBOutlet var bumpCountLabel: UILabel!
    
    
    
    @IBAction func myButtonPress(sender: AnyObject) {
    
        if (swichatron4000) {
            myLabel.text="Beep"
        } else{
            myLabel.text="Boop"
        }
        
        swichatron4000 = !swichatron4000
        bumpStart = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        motionKit.getDeviceMotionObject(interval: 0.05){
            (deviceMotion) -> () in

            let accelNum =
            sqrt(pow( deviceMotion.userAcceleration.x, 2) +
                 pow(deviceMotion.userAcceleration.y, 2) +
                 pow(deviceMotion.userAcceleration.z, 2))

    
            let accel = String(format:"%0.5f", accelNum)
            
            // detect the start of a bump
            if (self.bumpStart == false &&
                self.bumpEnd == false &&
                accelNum > 0.12) {
                    
                self.bumpStart = true
           
            }
            
            // Now detect for the end of a bump
            if (self.bumpStart == true &&
                self.bumpEnd == false &&
                accelNum <= 0.03) {
                    
                self.bumpEnd = true
            }
            
            
            dispatch_async(dispatch_get_main_queue()) {
                // now update UI on main thread
                self.myBumpDetector.text = "Accel is: " + accel
                
                if (self.bumpStart == true &&
                    self.bumpEnd == true) {
                    self.myLabel.text = "I got bumped"
    
                    self.bumpcount = self.bumpcount + 1
                    
                    
                
                    self.bumpCountLabel.text = String(self.bumpcount)
                    
                    self.bumpStart = false
                    self.bumpEnd = false
                        
                    
                }
                
            }
            
        }
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

