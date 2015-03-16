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
    var bumped = false
    
    @IBAction func myButtonPress(sender: AnyObject) {
    
        if (swichatron4000) {
            myLabel.text="thanks for squishing me"
        } else{
            myLabel.text="phew"
        }
        
        swichatron4000 = !swichatron4000
        bumped = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        motionKit.getDeviceMotionObject(interval: 0.1){
            (deviceMotion) -> () in

            let accelNum =
            sqrt(pow( deviceMotion.userAcceleration.x, 2) +
                 pow(deviceMotion.userAcceleration.y, 2) +
                 pow(deviceMotion.userAcceleration.z, 2))

    
            let accel = String(format:"%0.5f", accelNum)
            
            if (accelNum > 0.12) {
                self.bumped = true
            }
            
            
            dispatch_async(dispatch_get_main_queue()) {
                // now update UI on main thread
                self.myBumpDetector.text = "Accel is: " + accel
                
                if (self.bumped) {
                    self.myLabel.text = "I got bumped"
                }
                
            }
            
        }
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

