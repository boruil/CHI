import UIKit
import Firebase

class AddDietController: UITableViewController, GIDSignInUIDelegate {
    
    
    
    @IBOutlet var dateCell:DateCell!
    

    @IBOutlet weak var vegi: NumberCell!
    @IBOutlet weak var meat: NumberCell!
    
    @IBOutlet weak var weight: NumberCell!
    
    var ref: FIRDatabaseReference!

    var vegetableConsume:Double {
        get {
            return vegi.doubleValue
        }
    }
    
    
    var meatConsume:Double {
        get {
            return meat.doubleValue
        }
    }
    
    
    var bodyWeight:Double {
        get {
            return weight.doubleValue
        }
    }
    
    var date:NSDate {
        get {
            return dateCell.date
        }
    }
    
    func updateOKButtonStatus() {
        
        self.navigationItem.rightBarButtonItem?.enabled = ( vegi.doubleValue > 0 && meat.doubleValue > 0 && weight.doubleValue > 0);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = FIRDatabase.database().reference()

        dateCell.inputMode = .Date
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let formatter = NSLengthFormatter()
        formatter.unitStyle = .Long
        
        self.navigationItem.rightBarButtonItem?.enabled  = false
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func textFieldValueChanged(sender:AnyObject ) {
        updateOKButtonStatus()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath , animated: true)
        
        switch (indexPath.section, indexPath.row)
        {
        
        case (1,0):
            print("save sleeping data is hit")
            // update the result to the database
            print(GIDSignIn.sharedInstance().clientID)
            print(GIDSignIn.sharedInstance().currentUser.profile.email)
            print(GIDSignIn.sharedInstance().currentUser.userID)
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let dateString = dateFormatter.stringFromDate(self.date)
            print(dateString)
            self.ref.child("users").child(GIDSignIn.sharedInstance().currentUser.userID).child(dateString).child("Meat Calories").setValue(self.meatConsume * 1.43)
            print("meat saved")
            self.ref.child("users").child(GIDSignIn.sharedInstance().currentUser.userID).child(dateString).child("Vegetable Calories").setValue(self.vegetableConsume * 0.65)
            print("vegi saved")
            print(self.bodyWeight)
            self.ref.child("users").child(GIDSignIn.sharedInstance().currentUser.userID).child(dateString).child("Weight").setValue(self.bodyWeight)
            print("weight saved")

        default:
            break;
        }
    }

    
    
    
}

