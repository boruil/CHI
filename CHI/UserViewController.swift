//
//  UserViewController.swift
//  AR-Power
//
//  Created by Borui "Andy" Li on 2/7/16.
//  Copyright © 2016 Borui "Andy" Li. All rights reserved.
//

import Foundation
import UIKit
import ResearchKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImage.image = UIImage(named: "user")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
extension UserViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        
        //Handle results with taskViewController.result
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

