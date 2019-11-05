//
//  InterfaceController.swift
//  ActivityWithWatch Extension
//
//  Created by Vivek Batra on 2019-11-05.
//  Copyright © 2019 student. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        if WCSession.isSupported()
        {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    @IBAction func torontoPressed()
    {
        if (WCSession.default.isReachable == true)
        {
            let message = ["city":"toronto"] as [String : Any]
            WCSession.default.sendMessage(message, replyHandler:nil)
            print("message sent")
        }
        else
        {
            print("Message was not sent to Phone")
        }
        
       
    }

    @IBAction func tokyoPressed()
    {
        if (WCSession.default.isReachable == true)
        {
            let message = ["city":"tokyo"] as [String : Any]
            WCSession.default.sendMessage(message, replyHandler:nil)
            print("message sent")
        }
        else
        {
            print("Message was not sent to Phone")
        }
    }
    @IBAction func berlinPressed()
    {
        if (WCSession.default.isReachable == true)
        {
            let message = ["city":"berlin"] as [String : Any]
            WCSession.default.sendMessage(message, replyHandler:nil)
            print("message sent")
        }
        else
        {
            print("Message was not sent to Phone")
        }
    }
    @IBAction func delhiPressed()
    {
        if (WCSession.default.isReachable == true)
        {
            let message = ["city":"delhi"] as [String : Any]
            WCSession.default.sendMessage(message, replyHandler:nil)
            print("message sent")
        }
        else
        {
            print("Message was not sent to Phone")
        }
    }
}

