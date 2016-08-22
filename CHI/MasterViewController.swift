//
//  MasterViewController.swift
//  CHI
//  communicate information to/from Healthkit
//
//  Created by Borui "Andy" Li on 5/7/16.
//  Copyright © 2016 Borui "Andy" Li. All rights reserved.
//

import Foundation

import UIKit
import MessageUI



class MasterViewController: UITableViewController, MFMessageComposeViewControllerDelegate {
    
    let kAuthorizeHealthKitSection = 4
    let kProfileSegueIdentifier = "profileSegue"
    let kWorkoutSegueIdentifier = "workoutsSeque"
    
    let healthManager:HealthManager = HealthManager()
    
    func authorizeHealthKit()
    {
        healthManager.authorizeHealthKit { (success, error) -> Void in
            if success {
                print("HealthKit authorized!")
            } else {
                print("HK authorized denied!")
                if error != nil {
                    print("\(error)")
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier ==  kProfileSegueIdentifier {
            
            if let profileViewController = segue.destinationViewController as? HealthDataViewController {
                profileViewController.healthManager = healthManager
            }
        }
        else if segue.identifier == kWorkoutSegueIdentifier {
            if let workoutViewController = (segue.destinationViewController as! UINavigationController).topViewController as? DietTableViewController {
                workoutViewController.healthManager = healthManager;
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch (indexPath.section, indexPath.row)
        {
        case (kAuthorizeHealthKitSection,0):
            authorizeHealthKit()
        default:
            break
        }
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    // For message sending
    @IBAction func sendMessage(sender: AnyObject) {
        let messageVC = MFMessageComposeViewController()
        
        messageVC.body = "I don't feel well, please help!";
        messageVC.recipients = ["Care Provider"]
        messageVC.messageComposeDelegate = self;
        
        self.presentViewController(messageVC, animated: false, completion: nil)
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        switch (result.rawValue) {
        case MessageComposeResultCancelled.rawValue:
            print("Message was cancelled")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultFailed.rawValue:
            print("Message failed")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultSent.rawValue:
            print("Message was sent")
            self.dismissViewControllerAnimated(true, completion: nil)
        default:
            break;
        }
    }
}

