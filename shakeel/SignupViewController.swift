//
//  SignupViewController.swift
//  shakeel
//
//  Created by Tejen Hasmukh Patel on 4/16/16.
//  Copyright © 2016 ccsf. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var usernameFieldBackgroundView: UIView!
    @IBOutlet weak var passwordFieldBackgroundView: UIView!
    @IBOutlet weak var signupButtonSuperview: UIView!
    @IBOutlet weak var signinButtonSuperview: UIView!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var termsDisclaimerLabel: UILabel!
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var profilePicLabel: UILabel!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var canSubmit = false;
    var didSetProfilePic = false;

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        usernameField.delegate = self;
        passwordField.delegate = self;
        
        usernameField.attributedPlaceholder = NSAttributedString(string:"Username",
                                                                 attributes:[NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.7)]);
        passwordField.attributedPlaceholder = NSAttributedString(string:"Password",
                                                                 attributes:[NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.7)]);
        
        usernameFieldBackgroundView.layer.cornerRadius = 5.0;
        passwordFieldBackgroundView.layer.cornerRadius = 5.0;
        signupButtonSuperview.layer.cornerRadius = 5.0;
        signupButtonSuperview.layer.borderWidth = 2;
        signupButtonSuperview.layer.borderColor = UIColor(white: 1, alpha: 0.15).CGColor;
        
        //        termsDisclaimerLabel.attributedText
        let content = "By signing up, you agree to our ";
        let text = NSMutableAttributedString(string: content);
        text.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(14.0), range: NSRange(location: 0, length: content.characters.count));
        
        let linkText = "Terms & Privacy Policy";
        let link = NSMutableAttributedString(string: linkText);
        link.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(14.0, weight: UIFontWeightSemibold), range: NSRange(location: 0, length: linkText.characters.count));
        
        let punctuation = NSMutableAttributedString(string: ".");
        text.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(14.0), range: NSRange(location: 0, length: 1));
        
        text.appendAttributedString(link);
        text.appendAttributedString(punctuation);
        
        termsDisclaimerLabel.attributedText = text;
        
        usernameField.addTarget(self, action: "textFieldDidChange", forControlEvents: UIControlEvents.EditingChanged);
        passwordField.addTarget(self, action: "textFieldDidChange", forControlEvents: UIControlEvents.EditingChanged);
        
        profilePicImageView.clipsToBounds = true;
        profilePicImageView.layer.cornerRadius = profilePicImageView.frame.width/2;
        
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.usernameFieldBackgroundView.alpha = 1;
            self.passwordFieldBackgroundView.alpha = 1;
            self.signupButtonSuperview.alpha = 1;
            self.signinButtonSuperview.alpha = 1;
            self.termsDisclaimerLabel.alpha = 1;
            self.profilePicImageView.alpha = 1;
            self.profilePicLabel.alpha = 1;
        });
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.usernameFieldBackgroundView.alpha = 0;
            self.passwordFieldBackgroundView.alpha = 0;
            self.signupButtonSuperview.alpha = 0;
            self.signinButtonSuperview.alpha = 0;
            self.termsDisclaimerLabel.alpha = 0;
            self.profilePicImageView.alpha = 0;
            self.profilePicLabel.alpha = 0;
        }) { (success: Bool) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil);
        }
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        
        let username = usernameField.text!;
        let password = passwordField.text!;
        
        if(didSetProfilePic) {
            // upload profilePicImageView.image
        } else {
            // use default prof pic
        }
        
        startSubmitting();
        
        User.create(username, password: password, display_name: "test user") { (newUser: User?) in
            delay(1.0, closure: { 
                self.stopSubmitting();
            });
            if(newUser != nil && newUser!.id <= 0) {
                print("an error occurred while creating the new user... :/");
            } else {
                if(!User.login(newUser!, password: self.passwordField.text!)){
                    print("an unexpected fatal error occurred"); // this technically shouldn't be possible
                } else {
                    delay(0.5, closure: {
                        self.presentingViewController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil);
                    })
                }
            }
        }
    }
    
    func stopSubmitting() {
        enableSubmit();
        activityIndicatorView.alpha = 0;
        activityIndicatorView.stopAnimating();
        signupButton.setTitle("Sign Up", forState: .Normal);
    }
    
    func startSubmitting() {
        disableSubmit();
        signupButton.setTitle("", forState: .Normal);
        activityIndicatorView.startAnimating();
        activityIndicatorView.alpha = 1;
        
    }
    
    func enableSubmit() {
        canSubmit = true;
        signupButton.setTitleColor(UIColor(white: 1, alpha: 1), forState: .Normal);
        signupButton.userInteractionEnabled = true;
    }
    
    func disableSubmit() {
        canSubmit = false;
        signupButton.setTitleColor(UIColor(white: 1, alpha: 0.4), forState: .Normal);
        signupButton.userInteractionEnabled = false;
    }
    
    func textFieldDidChange() {
        if(usernameField.text?.characters.count > 0) {
            if(passwordField.text?.characters.count > 0) {
                enableSubmit();
                return;
            }
        }
        disableSubmit();
    }
    
    @IBAction func onProfilePic(sender: AnyObject) {
        let vc = UIImagePickerController();
        vc.delegate = self;
        vc.allowsEditing = true;
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
        presentViewController(vc, animated: true, completion: nil);
    }
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get the image captured by the UIImagePickerController
        //            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        profilePicImageView.contentMode = .ScaleAspectFill;
        profilePicImageView.layer.borderColor = UIColor.whiteColor().CGColor;
        profilePicImageView.layer.borderWidth = 2.0;
        profilePicImageView.image = editedImage;
        
        didSetProfilePic = true;
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true);
        return false;
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
