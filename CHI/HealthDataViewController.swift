import UIKit
import HealthKit

class HealthDataViewController: UITableViewController {
  
  let UpdateProfileInfoSection = 2
  let SaveBMISection = 3
  let kUnknownString   = "Unknown"
  
  @IBOutlet var ageLabel:UILabel!
  @IBOutlet var bloodTypeLabel:UILabel!
  @IBOutlet var biologicalSexLabel:UILabel!
  @IBOutlet var weightLabel:UILabel!
  @IBOutlet var heightLabel:UILabel!
  @IBOutlet var bmiLabel:UILabel!
  
  var healthManager:HealthManager? = HealthManager()
  var bmi:Double?
  var height, weight:HKQuantitySample?
  
  func updateHealthInfo() {
    
    updateProfileInfo();
    updateWeight();
    updateHeight();
    
  }
  
  func updateProfileInfo()
  {
    let profile = healthManager?.readProfile()
    if (profile == nil) {
        print("profile is nil")
    }
    
    ageLabel.text = profile?.age == nil ? kUnknownString : String(profile!.age!)
    biologicalSexLabel.text = biologicalSexLiteral(profile?.biologicalsex?.biologicalSex)
    bloodTypeLabel.text = bloodTypeLiteral(profile?.bloodtype?.bloodType)
  }
  
  
  func updateHeight()
  {
    let sampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)
    
    self.healthManager?.readMostRecentSample(sampleType!, completion: { (mostRecentHeight, error) -> Void in
        
        if( error != nil )
        {
            return;
        }
        
        var heightLocalizedString = self.kUnknownString;
        self.height = mostRecentHeight as? HKQuantitySample;

        if let meters = self.height?.quantity.doubleValueForUnit(HKUnit.meterUnit()) {
            let heightFormatter = NSLengthFormatter()
            heightFormatter.forPersonHeightUse = true;
            heightLocalizedString = heightFormatter.stringFromMeters(meters);
        }
        
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.heightLabel.text = heightLocalizedString
            self.updateBMI()
        });
    })
    
  }
  
  func updateWeight()
  {
    print("TODO: update Weight", terminator: "")

    let sampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
    
    self.healthManager?.readMostRecentSample(sampleType!, completion: { (mostRecentWeight, error) -> Void in
        
        if( error != nil )
        {
            print("Error reading weight from HealthKit Store: \(error.localizedDescription)")
            return;
        }
        
        var weightLocalizedString = self.kUnknownString;

        self.weight = mostRecentWeight as? HKQuantitySample;
        if let kilograms = self.weight?.quantity.doubleValueForUnit(HKUnit.gramUnitWithMetricPrefix(.Kilo)) {
            let weightFormatter = NSMassFormatter()
            weightFormatter.forPersonMassUse = true;
            weightLocalizedString = weightFormatter.stringFromKilograms(kilograms)
        }
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.weightLabel.text = weightLocalizedString
            self.updateBMI()
            
        });
    });
  }
  
  func updateBMI()
  {
    if weight != nil && height != nil {

        let weightInKilograms = weight!.quantity.doubleValueForUnit(HKUnit.gramUnitWithMetricPrefix(.Kilo))
        let heightInMeters = height!.quantity.doubleValueForUnit(HKUnit.meterUnit())
        bmi  = calculateBMIWithWeightInKilograms(weightInKilograms, heightInMeters: heightInMeters)
    }
    var bmiString = kUnknownString
    if bmi != nil {
        bmiLabel.text =  String(format: "%.02f", bmi!)
    }
    
  }
  
  func saveBMI() {
    if bmi != nil {
        healthManager?.saveBMISample(bmi!, date: NSDate())
    }
    else {
        print("There is no BMI data to save")
    }

    
  }
  func calculateBMIWithWeightInKilograms(weightInKilograms:Double, heightInMeters:Double) -> Double?
  {
    if heightInMeters == 0 {
      return nil;
    }
    return (weightInKilograms/(heightInMeters*heightInMeters));
  }
  
  
  func biologicalSexLiteral(biologicalSex:HKBiologicalSex?)->String
  {
    var biologicalSexText = kUnknownString;
    
    if  biologicalSex != nil {
      
      switch( biologicalSex! )
      {
      case .Female:
        biologicalSexText = "Female"
      case .Male:
        biologicalSexText = "Male"
      default:
        break;
      }
      
    }
    return biologicalSexText;
  }
  
  func bloodTypeLiteral(bloodType:HKBloodType?)->String
  {
    
    var bloodTypeText = kUnknownString;
    
    if bloodType != nil {
      
      switch( bloodType! ) {
      case .APositive:
        bloodTypeText = "A+"
      case .ANegative:
        bloodTypeText = "A-"
      case .BPositive:
        bloodTypeText = "B+"
      case .BNegative:
        bloodTypeText = "B-"
      case .ABPositive:
        bloodTypeText = "AB+"
      case .ABNegative:
        bloodTypeText = "AB-"
      case .OPositive:
        bloodTypeText = "O+"
      case .ONegative:
        bloodTypeText = "O-"
      default:
        break;
      }
      
    }
    return bloodTypeText;
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath , animated: true)
    
    switch (indexPath.section, indexPath.row)
    {
    case (UpdateProfileInfoSection,0):
      updateHealthInfo()
    case (SaveBMISection,0):
      saveBMI()
    default:
      break;
    }
  }
}