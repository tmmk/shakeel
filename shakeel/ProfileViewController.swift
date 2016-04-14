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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        blurEffectView.alpha = 0;
        blurEffectView.hidden = false;

        if(User.currentUser == nil) { // User is currently logged-out
            self.view.addSubview(self.blurEffectView);
            UIView.animateWithDuration(0.5) {
                self.blurEffectView.alpha = 0.7;
            }
            delay(0.6) {
                let LoginVC = Storyboard.instantiateViewControllerWithIdentifier("LoginNavigationController");
                self.presentViewController(LoginVC, animated: true, completion: nil);
            }
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidAppear(animated);
        
    }

    @IBAction func onOrdersButton(sender: AnyObject) {
        tabBarController?.selectedIndex = 0
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
