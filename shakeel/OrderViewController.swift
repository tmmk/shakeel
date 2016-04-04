//
//  OrderViewController.swift
//  shakeel
//
//  Created by mny on 3/15/16.
//  Copyright © 2016 ccsf. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var orderNumLabel: UILabel!
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var problemDescriptionLabel: UILabel!
    @IBOutlet weak var shippingETAlabel: UILabel!
    
    @IBOutlet weak var shadowEffectView: UIView!
    @IBOutlet weak var shadowEffectView2: UIView!
    
    var order: Order?
    var messages: [Message]?
    
    @IBOutlet weak var userMessageTextField: UITextField!
    @IBOutlet weak var userMessageSendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
        
        tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = shadowEffectView.bounds
        let topColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).CGColor as CGColorRef
        let bottomColor = UIColor(white: 0, alpha: 0.0).CGColor as CGColorRef
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0.0, 1.0]
        shadowEffectView.layer.addSublayer(gradientLayer)
        
        let gradientLayer2 = CAGradientLayer()
        gradientLayer2.frame = shadowEffectView2.bounds
        let bottomColor2 = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).CGColor as CGColorRef
        let topColor2 = UIColor(white: 0, alpha: 0.0).CGColor as CGColorRef
        gradientLayer2.colors = [topColor2, bottomColor2]
        gradientLayer2.locations = [0.0, 1.0]
        shadowEffectView2.layer.addSublayer(gradientLayer2)

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == 2) {
            return 260
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell") as! MessageCell
        cell.messageTextLabel.hidden = false
        cell.messageImageView.hidden = true
        cell.backgroundSuperview.backgroundColor = UIColor(red: 12/255.0, green: 210/255.0, blue: 27/255.0, alpha: 1)
        if(indexPath.row == 0) {
            cell.messageTextLabel.text = "Hi there, this is Shakeel!\nThank you very much for your order."
        }
        if(indexPath.row == 1) {
            cell.messageTextLabel.text = "Here's your shipping label..."
        }
        if(indexPath.row == 2) {
            cell.messageTextLabel.hidden = true
            cell.messageImageView.hidden = false
            cell.backgroundSuperview.backgroundColor = UIColor.clearColor()
        }
        if(indexPath.row == 3) {
            cell.messageTextLabel.text = "Take it to your nearest USPS and give them your phone. They'll handle the rest :)"
        }
        
        print("row \(indexPath.row)")
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
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
