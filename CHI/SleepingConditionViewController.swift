//
//  SleepingConditionViewController.swift
//  CHI
//
//  Created by Borui "Andy" Li on 5/21/16.
//  Copyright © 2016 Borui "Andy" Li. All rights reserved.
//

import Foundation
import UIKit
import HealthKit
import Firebase

class SleepingConditionViewController: UITableViewController, GIDSignInUIDelegate {
    
    var ref: FIRDatabaseReference!
    
    let UpdateSleepingConditionSection = 1
    let SaveDataSection = 2
    let kUnknownString   = "Unknown"
    var myHealthStore:HKHealthStore = HKHealthStore()
    var sleepingTime = 0.0

    
    @IBOutlet weak var SleepingCondition: UILabel!
    
    var healthManager:HealthManager? = HealthManager()
    var bmi:Double?
    var sleep:HKCategorySample?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myHealthStore = HKHealthStore()
        
        self.ref = FIRDatabase.database().reference()
    }
    
    func updateHealthInfo() {
        
        updateProfileInfo();
        updateSleep();
        
    }
    
    
    func updateProfileInfo()
    {
        let profile = healthManager?.readProfile()
        if (profile == nil) {
            print("profile is nil")
        }
        
//        ageLabel.text = profile?.age == nil ? kUnknownString : String(profile!.age!)
//        biologicalSexLabel.text = biologicalSexLiteral(profile?.biologicalsex?.biologicalSex)
//        bloodTypeLabel.text = bloodTypeLiteral(profile?.bloodtype?.bloodType)
    }
    
    
    func updateSleep()
    {
        var error: NSError?
        
        // 取得したいデータのタイプを生成.
        let typeOfSleep:HKSampleType = HKSampleType.categoryTypeForIdentifier(HKCategoryTypeIdentifierSleepAnalysis)!
        
        let calendar: NSCalendar! = NSCalendar.currentCalendar()
        let now: NSDate = NSDate()
        
        let startDate: NSDate = calendar.startOfDayForDate(now)
        let endDate: NSDate = calendar.dateByAddingUnit(.Day, value: 1, toDate: startDate, options: [])!
        
        let predicate: NSPredicate = HKQuery.predicateForSamplesWithStartDate(startDate, endDate: endDate, options: HKQueryOptions.None)
        
        // データ取得時に登録された時間でソートするためのDescriptorを生成.
        let mySortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
        
        // データ読み出しのためのqueryを生成.
        let mySampleQuery = HKSampleQuery(sampleType: typeOfSleep, predicate: predicate, limit: 1, sortDescriptors: [mySortDescriptor])
        { (sampleQuery, results, error ) -> Void in
            
            // 一番最近に登録されたデータを取得.
            let myRecentSample = results!.first as HKSample?
            
            if !myRecentSample!.isEqual(nil) {
                
                // 就寝時間と起床時間を取り出す.
                var myGoBedTime:NSDate = myRecentSample!.startDate
                var myWeakUpTime:NSDate = myRecentSample!.endDate
                
                // 時間の差から睡眠時間を計算.
                var mySleepTime:NSTimeInterval = myWeakUpTime.timeIntervalSinceDate(myGoBedTime)
                
                dispatch_async(dispatch_get_main_queue(),{
                    self.sleepingTime = Double(round(100*(mySleepTime/(60*60)))/100)
                    self.SleepingCondition.text = "\(self.sleepingTime) hours"
                })
            } else {
                print("error")
            }
        }
        
        // queryを発行.
        self.myHealthStore.executeQuery(mySampleQuery)
    }
    
//    func updateBMI()
//    {
//        if weight != nil && height != nil {
//            
//            let weightInKilograms = weight!.quantity.doubleValueForUnit(HKUnit.gramUnitWithMetricPrefix(.Kilo))
//            let heightInMeters = height!.quantity.doubleValueForUnit(HKUnit.meterUnit())
//            bmi  = calculateBMIWithWeightInKilograms(weightInKilograms, heightInMeters: heightInMeters)
//        }
//        var bmiString = kUnknownString
//        if bmi != nil {
//            //        bmiLabel.text =  String(format: "%.02f", bmi!)
//        }
//        
//    }
//    
//    func saveBMI() {
//        if bmi != nil {
//            healthManager?.saveBMISample(bmi!, date: NSDate())
//        }
//        else {
//            print("There is no BMI data to save")
//        }
//        
//        
//    }
//    func calculateBMIWithWeightInKilograms(weightInKilograms:Double, heightInMeters:Double) -> Double?
//    {
//        if heightInMeters == 0 {
//            return nil;
//        }
//        return (weightInKilograms/(heightInMeters*heightInMeters));
//    }
//    
//    
//    func biologicalSexLiteral(biologicalSex:HKBiologicalSex?)->String
//    {
//        var biologicalSexText = kUnknownString;
//        
//        if  biologicalSex != nil {
//            
//            switch( biologicalSex! )
//            {
//            case .Female:
//                biologicalSexText = "Female"
//            case .Male:
//                biologicalSexText = "Male"
//            default:
//                break;
//            }
//            
//        }
//        return biologicalSexText;
//    }
//    
//    func bloodTypeLiteral(bloodType:HKBloodType?)->String
//    {
//        
//        var bloodTypeText = kUnknownString;
//        
//        if bloodType != nil {
//            
//            switch( bloodType! ) {
//            case .APositive:
//                bloodTypeText = "A+"
//            case .ANegative:
//                bloodTypeText = "A-"
//            case .BPositive:
//                bloodTypeText = "B+"
//            case .BNegative:
//                bloodTypeText = "B-"
//            case .ABPositive:
//                bloodTypeText = "AB+"
//            case .ABNegative:
//                bloodTypeText = "AB-"
//            case .OPositive:
//                bloodTypeText = "O+"
//            case .ONegative:
//                bloodTypeText = "O-"
//            default:
//                break;
//            }
//            
//        }
//        return bloodTypeText;
//    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath , animated: true)
        
        switch (indexPath.section, indexPath.row)
        {
        case (UpdateSleepingConditionSection,0):
            print("Read sleeping condition is hit")
            updateSleep()
        case (SaveDataSection,0):
            print("save sleeping data is hit")
            // update the result to the database
            print(GIDSignIn.sharedInstance().clientID)
            print(GIDSignIn.sharedInstance().currentUser.profile.email)
            print(GIDSignIn.sharedInstance().currentUser.userID)
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let dateString = dateFormatter.stringFromDate(NSDate())
            self.ref.child("users").child(GIDSignIn.sharedInstance().currentUser.userID).child(dateString).child("sleeping_time").setValue(self.sleepingTime)
        default:
            break;
        }
    }
}