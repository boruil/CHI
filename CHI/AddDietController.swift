import UIKit

class AddDietController: UITableViewController {
    
    
    
    @IBOutlet var dateCell:DateCell!
    

    @IBOutlet weak var vegi: NumberCell!
    @IBOutlet weak var meat: NumberCell!
    
    
    
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
    
    
    
    func updateOKButtonStatus() {
        
        self.navigationItem.rightBarButtonItem?.enabled = ( vegi.doubleValue > 0 && meat.doubleValue > 0);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    @IBAction func textFieldValueChanged(sender:AnyObject ) {
        updateOKButtonStatus()
    }
    
    
    
}

