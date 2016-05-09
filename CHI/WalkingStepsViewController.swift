import UIKit
import HealthKit

class WalkingStepsViewController: UITableViewController {
    
    let UpdateProfileInfoSection = 1
    let SaveBMISection = 2
    let kUnknownString   = "Unknown"
    
    @IBOutlet var stepsLabel:UILabel!
    
    @IBOutlet var aveStepsLabel: UILabel!
    
    var healthManager:HealthManager? = HealthManager()
    var bmi:Double?
    var steps:HKQuantitySample?
    
    func updateHealthInfo() {
        updateDailySteps();
        
    }
    
    func updateDailySteps() {
        let sampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)
        
        // 2. Call the method to read the most recent Height sample
        self.healthManager?.readMostRecentSample(sampleType!, completion: { (mostRecentSteps, error) -> Void in
            
            if( error != nil )
            {
                print("Error reading height from HealthKit Store: \(error.localizedDescription)")
                return;
            }
            
            var stepsLocalizedString = self.kUnknownString;
            self.steps = mostRecentSteps as? HKQuantitySample;
            let value = Int((self.steps?.quantity.doubleValueForUnit(HKUnit.countUnit()))!)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.stepsLabel.text = String(value)
                self.aveStepsLabel.text = String(value)
            });
        })
        
    }
}