//
//  ViewController.swift
//  AR-Power
//
//  Created by Borui "Andy" Li on 1/22/16.
//  Copyright © 2016 Borui "Andy" Li. All rights reserved.
//

import UIKit
import ResearchKit

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    var termsAccepted = false
    
    @IBOutlet weak var TextFieldUserName: UITextField!
    @IBOutlet weak var TextFieldPassword: UITextField!
    
    @IBOutlet weak var login: UILabel!
    
    @IBAction func signOut(sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
    }

    
    @IBAction func verify(sender: AnyObject) {
//        var notification = UILocalNotification()
//        notification.alertBody = "Your health index is improved! Great job and keep going!" // text that will be displayed in the notification
//        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
//        
//        var dateAsString = "13 May 2016 14:39:33"
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss"
//        var newDate = dateFormatter.dateFromString(dateAsString)
//        
//        notification.fireDate = newDate // todo item due date (when notification will be fired)
//        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
//        //        notification.userInfo = ["UUID": item.UUID, ] // assign a unique identifier to the notification so that we can retrieve it later
//        notification.category = "TODO_CATEGORY"
//        UIApplication.sharedApplication().scheduleLocalNotification(notification)
//        let mainTask = storyboard!.instantiateViewControllerWithIdentifier("main_menu")
//        presentViewController(mainTask, animated: true, completion: nil)
        
        refresh()
    }
    
    func refresh() {
        print("hey sup")
        login.hidden = false
        if let currentUser = GIDSignIn.sharedInstance().currentUser {
            print("there is a user")
            login.hidden = false
            let mainTask = storyboard!.instantiateViewControllerWithIdentifier("main_menu")
            presentViewController(mainTask, animated: true, completion: nil)
        } else {
            print("no user is here")
            login.hidden = true

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
        (UIApplication.sharedApplication().delegate as! AppDelegate).signInCallback = refresh
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        refresh()
        (UIApplication.sharedApplication().delegate as! AppDelegate).signInCallback = refresh

        
        if (!termsAccepted) {
            let taskViewController = ORKTaskViewController(task: ConsentTask, taskRunUUID: nil)
            taskViewController.delegate = self
            presentViewController(taskViewController, animated: true, completion: nil)

        }
    }
    
    
}
extension LoginViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        
        //Handle results with taskViewController.result
        termsAccepted = true

        taskViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

