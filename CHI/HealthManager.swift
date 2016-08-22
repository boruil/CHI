//
//  HealthManager.swift
//  CHI
//
//  Created by Borui "Andy" Li on 5/7/16.
//  Copyright © 2016 Borui "Andy" Li. All rights reserved.
//

import Foundation

import HealthKit

class HealthManager {
    let healthKitStore:HKHealthStore = HKHealthStore()
    
    
    func authorizeHealthKit(completion: ((success:Bool, error:NSError!) -> Void)!) {
        
        var readType = Set<HKObjectType>()
        readType.insert(HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierDateOfBirth)!)
        readType.insert(HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierBloodType)!)
        readType.insert(HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierBiologicalSex)!)
        readType.insert(HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)!)
        readType.insert(HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)!)
        readType.insert(HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)!)
        readType.insert(HKObjectType.categoryTypeForIdentifier(HKCategoryTypeIdentifierSleepAnalysis)!)
        readType.insert(HKObjectType.workoutType())
        
        var writeType = Set<HKSampleType>()
        writeType.insert(HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMassIndex)!)
        writeType.insert(HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned)!)
        writeType.insert(HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning)!)
        writeType.insert(HKQuantityType.workoutType())
        
        if !HKHealthStore.isHealthDataAvailable() {
            let error = NSError(domain: "com.boruili.CHI", code: 2, userInfo:[NSLocalizedDescriptionKey:"HealthKit is not available in this Device"])
            if (completion != nil) {
                completion(success:false, error:error)
            }
            return;
        }
        
        healthKitStore.requestAuthorizationToShareTypes(writeType, readTypes: readType) { (success, error) -> Void in
            if( completion != nil ) {
                completion(success:success,error:error)
            }
        }
        
    }
    
    func readProfile() -> ( age:Int?,  biologicalsex:HKBiologicalSexObject?, bloodtype:HKBloodTypeObject?)
    {
        print("read profile get called")
        var age:Int?
        var biologicalSex:HKBiologicalSexObject?
        var bloodType:HKBloodTypeObject?
        
        do {
            let birthDay = try healthKitStore.dateOfBirth()
            let today = NSDate()
            let differenceComponents = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: birthDay, toDate: today, options: NSCalendarOptions(rawValue: 0) )
            age = differenceComponents.year
            
        } catch {
            print("Error reading Birthday: \(error)")
        }
        
        do {
            biologicalSex = try healthKitStore.biologicalSex();
            
        } catch {
            print("Error reading Biological Sex: \(error)")
        }
        
        do {
            bloodType = try healthKitStore.bloodType();
            
        } catch {
            print("Error reading Blood Type: \(error)")
        }
        
        print("age is: ",age)
        return (age, biologicalSex, bloodType)
    }
    
    func readMostRecentSample(sampleType:HKSampleType , completion: ((HKSample!, NSError!) -> Void)!)
    {
        
        let past = NSDate.distantPast() 
        let now   = NSDate()
        let mostRecentPredicate = HKQuery.predicateForSamplesWithStartDate(past, endDate:now, options: .None)
        
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
        let limit = 1
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: mostRecentPredicate, limit: limit, sortDescriptors: [sortDescriptor])
        { (sampleQuery, results, error ) -> Void in
            
            if error != nil {
                completion(nil,error)
                return;
            }
            
            let mostRecentSample = results!.first as? HKQuantitySample
            
            if completion != nil {
                completion(mostRecentSample,nil)
            }
        }
        self.healthKitStore.executeQuery(sampleQuery)
    }
    
    func saveBMISample(bmi:Double, date:NSDate ) {
        
        let bmiType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMassIndex)
        let bmiQuantity = HKQuantity(unit: HKUnit.countUnit(), doubleValue: bmi)
        let bmiSample = HKQuantitySample(type: bmiType!, quantity: bmiQuantity, startDate: date, endDate: date)
        
        healthKitStore.saveObject(bmiSample, withCompletion: { (success, error) -> Void in
            if( error != nil ) {
                print("Error saving BMI sample: \(error!.localizedDescription)")
            } else {
                print("BMI sample saved successfully!")
            }
        })
    }
    
    func saveRunningWorkout(startDate:NSDate , endDate:NSDate , distance:Double, distanceUnit:HKUnit , kiloCalories:Double,
                            completion: ( (Bool, NSError!) -> Void)!) {
        
        let distanceQuantity = HKQuantity(unit: distanceUnit, doubleValue: distance)
        let caloriesQuantity = HKQuantity(unit: HKUnit.kilocalorieUnit(), doubleValue: kiloCalories)
        
        let workout = HKWorkout(activityType: HKWorkoutActivityType.Running, startDate: startDate, endDate: endDate, duration: abs(endDate.timeIntervalSinceDate(startDate)), totalEnergyBurned: caloriesQuantity, totalDistance: distanceQuantity, metadata: nil)
        healthKitStore.saveObject(workout, withCompletion: { (success, error) -> Void in
            if( error != nil  ) {
                completion(success,error)
            }
            else {
                completion(success,nil)
                
            }
        })
    }
}