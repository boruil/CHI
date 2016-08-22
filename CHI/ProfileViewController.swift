//
//  ProfileViewController.swift
//  CHI
//
//  Created by Borui "Andy" Li on 5/18/16.
//  Copyright © 2016 Borui "Andy" Li. All rights reserved.
//

import Foundation

import UIKit
import Firebase


class ProfileViewController: UITableViewController, GIDSignInUIDelegate {
    
    
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var gender: UILabel!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    
//    @IBOutlet weak var Credit: UILabel!

    var ref: FIRDatabaseReference!

    func refe() {
        if GIDSignIn.sharedInstance().currentUser != nil {
            let currentUser = GIDSignIn.sharedInstance().currentUser
            print("there is a user")
            let profilePicUrl = currentUser.profile.imageURLWithDimension(175)
            profile.image = UIImage(data: NSData(contentsOfURL: profilePicUrl)!)
            name.text = currentUser.profile.givenName
            gender.text = currentUser.profile.familyName
            email.text = currentUser.profile.email
            
            
        } else {
            print("no user is here")
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refe()
        (UIApplication.sharedApplication().delegate as! AppDelegate).signInCallback = refe
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        self.ref = FIRDatabase.database().reference()
        let currentUser = GIDSignIn.sharedInstance().currentUser

        self.ref.child("users").child(GIDSignIn.sharedInstance().currentUser.userID).child("given name").setValue(currentUser.profile.givenName)
        
        self.ref.child("users").child(GIDSignIn.sharedInstance().currentUser.userID).child("family  name").setValue(currentUser.profile.familyName)
        self.ref.child("users").child(GIDSignIn.sharedInstance().currentUser.userID).child("email").setValue(currentUser.profile.email)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        refe()
        (UIApplication.sharedApplication().delegate as! AppDelegate).signInCallback = refe
    }
}

