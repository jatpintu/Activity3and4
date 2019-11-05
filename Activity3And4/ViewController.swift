//
//  ViewController.swift
//  Activity3And4
//
//  Created by Vivek Batra on 2019-11-02.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Particle_SDK
import WatchConnectivity


class ViewController: UIViewController, WCSessionDelegate {
    
    
    let USERNAME = "vivekbatra456@gmail.com"
    let PASSWORD = "mightbeiamwrong"
    
    let DEVICE_ID = "220026000f47363333343437"
    var myPhoton : ParticleDevice?
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var latLabel: UITextField!
    @IBOutlet weak var longLabel: UITextField!
    
//    var lat : String = ""
//    var long : String = ""
    var hours : String = ""
    var minutes : String = ""
    
    var precipitationProbability : Double = 0.0
    var temperatureInF : Double = 0.0
    var temperatureInC : Double = 0.0
    var timeZone : String = ""
    var dateTime : String = ""
    var cityName : String = ""
    var latitude : String = ""
    var longitude : String = ""
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?)
    {
        if WCSession.isSupported()
        {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession)
    {
    }
    
    func sessionDidDeactivate(_ session: WCSession)
    {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ParticleCloud.init()
        if (WCSession.isSupported() == true)
        {
            print("WC is supported!")
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        else
        {
            print("WC NOT supported!")
        }
    
        
        ParticleCloud.sharedInstance().login(withUser: self.USERNAME, password: self.PASSWORD) { (error:Error?) -> Void in
            if (error != nil) {
                // Something went wrong!
                print("Wrong credentials or as! ParticleCompletionBlock no internet connectivity, please try again")
                // Print out more detailed information
                print(error?.localizedDescription)
            }
            else {
                print("Login success!")
                
                // try to get the device
                self.getDeviceFromCloud()
                
            }
        } // end login
        
        
        
    }
    
    
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any])
    {
        print("Message Received")
        
        self.cityName = message["city"] as! String
        if(self.cityName == "toronto")
        {
            self.latitude = "43.6532"
            self.longitude = "-79.3832"
            
        }
        else if (self.cityName == "tokyo")
        {
            self.latitude = "35.6762"
            self.longitude = "139.6503"
            
        }
        else if (self.cityName == "berlin")
        {
            self.latitude = "52.5200"
            self.longitude = "13.4050"
            
        }
        else if (self.cityName == "delhi")
        {
            self.latitude = "28.7041"
            self.longitude = "77.1025"
        }
        latLabel.text = "\(self.latitude)"
        longLabel.text = "\(self.longitude)"
        AF.request("https://api.darksky.net/forecast/f4928996d8cac3a6d31cf7860376e0d8/\(self.latitude),\(self.longitude)").responseJSON
            {
                
                (xyz) in
                let x = JSON(xyz.value)
                
                self.precipitationProbability = x["currently"]["precipProbability"].double!
                self.temperatureInF = x["currently"]["temperature"].double!
                self.temperatureInC = (self.temperatureInF - 32.00) * (5 / 9)
                self.timeZone = x["timezone"].string!
                
                
                AF.request("https://worldtimeapi.org/api/timezone/\(self.timeZone)").responseJSON
                    {
                        
                        (abc) in
                        let y = JSON(abc.value)
                        
                        self.dateTime = y["datetime"].string!
                        
                        let seprated1 = self.dateTime.components(separatedBy: "T")
                        let seprated2 = seprated1[1].components(separatedBy: ".")
                        let seprtated3:[String] = seprated2[0].components(separatedBy: ":")
                        self.hours = seprtated3[0]
                        self.minutes = seprtated3[1]
                        
                        
                        print("precipitationProbability: \(self.precipitationProbability)")
                        print("temperature in F: \(self.temperatureInF)")
                        print("temperature in C: \(self.temperatureInC)")
                        print("TimeZOne is : \(self.timeZone)")
                        print("Hours : \(self.hours)")
                        print("Minutes : \(self.minutes)")
                }
                
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getDeviceFromCloud() {
        ParticleCloud.sharedInstance().getDevice(self.DEVICE_ID) { (device:ParticleDevice?, error:Error?) in
            
            if (error != nil) {
                print("Could not get device")
                print(error?.localizedDescription)
                return
            }
            else {
                print("Got photon from cloud: \(device?.id)")
                self.myPhoton = device
                
           
                 // subscribe to events events events events events
            }
            
        } // end getDevice()
    }

    
  
    @IBAction func showPrecipitationButtonPressed(_ sender: Any)
    {
        
        let parameters = ["\(self.precipitationProbability)"]
        var task = self.myPhoton!.callFunction("precipitation", withArguments: parameters)
        {
            (resultCode : NSNumber?, error : Error?) -> Void in
            if (error == nil)
            {
                print("Precipitation sent to particle")
            }
            else
            {
                print("Precipitation was not sent to particle")
            }
        }
        self.imageView.image = UIImage(named: "precipitation")
    }
    
    @IBAction func showTempButtonPressed(_ sender: Any)
    {
       
        let parameters = ["\(self.temperatureInC)"]
        var task = self.myPhoton!.callFunction("temprature", withArguments: parameters)
        {
            (resultCode : NSNumber?, error : Error?) -> Void in
            if (error == nil)
            {
                print("Temprature sent to particle")
            }
            else
            {
                print("Temprature was not sent to particle")
            }
        }
        self.imageView.image = UIImage(named: "temperature")

    }

    
    @IBAction func shoeTimeButtonPressed(_ sender: Any)
    {
        var hr = Int(self.hours)
        if (hr! > 12)
        {
            hr = hr! - 12
        }
        if(hr! != 12)
        {
            let parameters = ["\(hr!)"]
            var task = self.myPhoton!.callFunction("hours", withArguments: parameters)
            {
                (resultCode : NSNumber?, error : Error?) -> Void in
                if (error == nil)
                {
                    print("Hours sent to particle")
                }
                else
                {
                    print("Hours was not sent to particle")
                }
            }
            
            let min = Int(self.minutes)
            let parameters1 = ["\(min!/5)"]
            var task1 = self.myPhoton!.callFunction("minutes", withArguments: parameters1)
            {
                (resultCode : NSNumber?, error : Error?) -> Void in
                if (error == nil)
                {
                    print("Minutes sent to particle")
                }
                else
                {
                    print("Minutes was not sent to particle")
                }
            }
            self.imageView.image = UIImage(named: "time")
        }
            
        else
        {
            let min = Int(self.minutes)
            let parameters1 = ["\(min!/5)"]
            var task1 = self.myPhoton!.callFunction("minutes", withArguments: parameters1)
            {
                (resultCode : NSNumber?, error : Error?) -> Void in
                if (error == nil)
                {
                    print("Minutes sent to particle")
                }
                else
                {
                    print("Minutes was not sent to particle")
                }
            }
            self.imageView.image = UIImage(named: "time")
        }
    }
    
    
    
    


}
