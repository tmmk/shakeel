//
//  LoginViewController.swift
//  shakeel
//
//  Created by Tejen Hasmukh Patel on 4/11/16.
//  Copyright © 2016 ccsf. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var closeButtonSuperview: UIView!
    
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signinActivityIndicator: UIActivityIndicatorView!
    
    @IBAction func onSignInButton(sender: AnyObject) {
        signinButton.hidden = true;
        signinActivityIndicator.startAnimating();
        User.get({ (potentialUser: User?) in
            // check validity
            delay(0.2, closure: { 
                self.signinActivityIndicator.stopAnimating();
                self.signinButton.hidden = false;
            });
            
            if(potentialUser == nil) {
                alert("Uh oh!", message: "No user exists by that username.", button: "Try Again");
            } else {
                if(potentialUser!.passwordDoesMatch(self.passwordTextfield.text!)) {
                    User.login(potentialUser!, password: self.passwordTextfield.text!)
                    self.dismissViewControllerAnimated(true, completion: nil);
                } else {
                    alert("Uh oh!", message: "Invalid password.", button: "Try Again");
                }
            }
        }, username: usernameTextfield.text!);
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        closeButtonSuperview.layer.cornerRadius = 25/2;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCloseButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil);
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
