//
//  ViewController.swift
//  AR-Power
//
//  Created by Borui "Andy" Li on 1/22/16.
//  Copyright © 2016 Borui "Andy" Li. All rights reserved.
//

import UIKit
import ResearchKit

class LoginViewController: UIViewController {
    
    
    
    
    
    
    @IBOutlet weak var TextFieldUserName: UITextField!
    @IBOutlet weak var TextFieldPassword: UITextField!
    
    @IBOutlet weak var login: UILabel!
    
    
    @IBAction func Verify(sender: AnyObject) {
        
        //        if TextFieldUserName.text == usr &&
        //            TextFieldPassword.text == pw {
        //
        //            TextFieldUserName.resignFirstResponder()
        //            TextFieldPassword.resignFirstResponder()
        //
        //            let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTask = storyboard!.instantiateViewControllerWithIdentifier("main_menu")
        presentViewController(mainTask, animated: true, completion: nil)
        //        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        if NSUserDefaults.standardUserDefaults().boolForKey("TermsAccepted") {
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "TermsAccepted")
            
        } else {
            
            let taskViewController = ORKTaskViewController(task: ConsentTask, taskRunUUID: nil)
            taskViewController.delegate = self
            presentViewController(taskViewController, animated: true, completion: nil)
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "TermsAccepted")
        }
    }
    
    
}
extension LoginViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        
        //Handle results with taskViewController.result
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

