//
//  ViewController.swift
//  countDown
//
//  Created by Byron Luo on 2016-01-13.
//  Copyright © 2016 byronluo.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var countDownTime: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCountDown(sender: AnyObject) {
        saveCurrentDate()
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateTime", userInfo: nil, repeats: true)
    }
    
    func updateTime(){
        let timeSinceNow:NSInteger = NSInteger(self.timePicker.date.timeIntervalSinceNow)
        timeComputation(timeSinceNow)
    
    }
    
    @IBAction func restart(sender: UIButton) {
        let preferences = NSUserDefaults.standardUserDefaults();
        let key = "formerDate"
        if preferences.objectForKey(key) == nil{
            print("no formerDate in UserDefaults")
        }else{
                 NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "restartComputation", userInfo: nil, repeats: true)
            
        }
    }
    
    func restartComputation(){
        let preferences = NSUserDefaults.standardUserDefaults();
        let key = "formerDate"
        let value = NSDate(timeIntervalSince1970: preferences.doubleForKey(key))
        timeComputation(NSInteger(value.timeIntervalSinceNow))
    }
    
    func saveCurrentDate(){
        let preferences = NSUserDefaults.standardUserDefaults()
        let key = "formerDate"
        let value = self.timePicker.date.timeIntervalSince1970;
        preferences.setDouble(value, forKey: key)
        
        let didSave = preferences.synchronize();
        if !didSave{
            print("unable to save the formerDate")
        }
    }
    
    func timeComputation(timeSinceNow:NSInteger){
        let days = (timeSinceNow/86400)
        let hours = (timeSinceNow/3600)%24
        let mins = (timeSinceNow/60)%60
        let secs = timeSinceNow%60
        
        countDownTime.text = "\(days) days \(hours) hours \(mins) mins \(secs) secs"
        
    }
    


}

