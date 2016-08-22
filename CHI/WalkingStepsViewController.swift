import UIKit
import HealthKit
import Firebase

class WalkingStepsViewController: UITableViewController, GIDSignInUIDelegate {
    
    let UpdateProfileInfoSection = 1
    let SaveBMISection = 2
    let kUnknownString   = "Unknown"
    
    @IBOutlet var stepsLabel:UILabel!
    var ref: FIRDatabaseReference!

    
//    @IBOutlet var aveStepsLabel: UILabel!
    
    var healthManager:HealthManager? = HealthManager()
    var bmi:Double?
    var steps:HKQuantitySample?
    var walkingSteps = 0
    
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
            self.walkingSteps = value
            print(value)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.stepsLabel.text = String(value)
//                self.aveStepsLabel.text = String(value)
            });
        })
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath , animated: true)
        self.ref = FIRDatabase.database().reference()

        switch (indexPath.section, indexPath.row)
        {
        case (UpdateProfileInfoSection,0):
            print("Read sleeping condition is hit")
            updateDailySteps()
        case (SaveBMISection,0):
            print("save sleeping data is hit")
            // update the result to the database
            print(GIDSignIn.sharedInstance().clientID)
            print(GIDSignIn.sharedInstance().currentUser.profile.email)
            print(GIDSignIn.sharedInstance().currentUser.userID)
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let dateString = dateFormatter.stringFromDate(NSDate())
            self.ref.child("users").child(GIDSignIn.sharedInstance().currentUser.userID).child(dateString).child("walking_steps").setValue(self.walkingSteps)
        default:
            break;
        }
    }

}