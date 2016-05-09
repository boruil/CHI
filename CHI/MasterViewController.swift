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


class MasterViewController: UITableViewController {
    
    let kAuthorizeHealthKitSection = 5
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
}

