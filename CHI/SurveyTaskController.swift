//
//  SurveyTaskController.swift
//  HelloMedicalResearch
//
//  Modified by Borui "Andy" Li on 12/8/15.
//  Copyright © 2015 Borui "Andy" Li. All rights reserved.
//

import UIKit
import ResearchKit

class SurveyTaskController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func surveyTextTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: SurveyTextTask1, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }
    @IBAction func surveyImageTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: SurveyImageTask1, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }
    
    @IBAction func microphoneTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: SurveyImageTask1, taskRunUUID: nil)
        taskViewController.delegate = self
        taskViewController.outputDirectory = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String, isDirectory: true)
        presentViewController(taskViewController, animated: true, completion: nil)
    }
}

// let view controller implements ORKTaskViewControllerDelegate
extension SurveyTaskController : ORKTaskViewControllerDelegate {
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        // Handle results with taskViewController.result
        _ = taskViewController.result
        // do something with the result here:
        
        
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
