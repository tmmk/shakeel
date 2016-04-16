//
//  ProfileViewController.swift
//  shakeel
//
//  Created by mny on 3/15/16.
//  Copyright © 2016 ccsf. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light));

    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var connectAccountButtonSuperview: UIView!
    @IBOutlet weak var profileIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        view.addSubview(self.blurEffectView);
        connectAccountButtonSuperview.layer.cornerRadius = 25;
//        connectAccountButtonSuperview.layer.shouldRasterize = true;
        connectAccountButtonSuperview.layer.shadowColor = UIColor.blackColor().CGColor;
        connectAccountButtonSuperview.layer.shadowOpacity = 0.4;
        connectAccountButtonSuperview.layer.shadowOffset = CGSizeZero;
        connectAccountButtonSuperview.layer.shadowRadius = 5;
        
        editProfileButton.hidden = true;
        
        profileIcon.layer.cornerRadius = profileIcon.bounds.width / 2;

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);

        displayLoginButtonIfNecessary();
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidAppear(animated);
        
    }

    @IBAction func onOrdersButton(sender: AnyObject) {
        tabBarController?.selectedIndex = 0
    }
    
    @IBAction func onConnectAccountButton(sender: AnyObject) {
        let LoginVC = Storyboard.instantiateViewControllerWithIdentifier("LoginViewController");
        self.presentViewController(LoginVC, animated: true, completion: nil);
    }
    
    func displayLoginButtonIfNecessary(){
        if(User.currentUser == nil) { // User is currently logged-out
            view.bringSubviewToFront(connectAccountButtonSuperview);
            blurEffectView.alpha = 0.8;
            blurEffectView.hidden = false;
            connectAccountButtonSuperview.hidden = false;
            editProfileButton.hidden = true;
        } else {
            editProfileButton.hidden = false;
            blurEffectView.hidden = true;
            connectAccountButtonSuperview.hidden = true;
        }
    }
    
    @IBAction func onSignoutButton(sender: AnyObject) {
        User.logout();
        displayLoginButtonIfNecessary();
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
