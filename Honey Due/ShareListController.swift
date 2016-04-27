//
//  AddTaskViewController.swift
//  Honey Due
//
//  Created by C412IT44 on 2016-04-13.
//  Copyright © 2016 Scott Legrove. All rights reserved.
//

import UIKit

class ShareListViewController: UIViewController{
    var currentList: Int?
    var uPrefs: NSUserDefaults?
    var uToken: String?
    
    @IBOutlet weak var username: UITextField!
    
    @IBAction func btnShare(sender: AnyObject) {
        let shared = UserHelper.AddUser(currentList!, username: username!.text!, token: uToken!)
        
        if shared {
            let alertController = UIAlertController(title: "List shared successfully!", message: "List shared with the specified user!", preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: "OK",  style: .Default){
                (_) in
                    self.navigationController?.popViewControllerAnimated(true)
            }
            
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true){}
        }
        else
        {
            let alertController = UIAlertController(title: "List could not be shared", message: "The specified user does not exist.", preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: "OK",  style: .Default){
                (_) in
            }
            
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true){}
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uPrefs = NSUserDefaults.standardUserDefaults()
        uToken = uPrefs!.stringForKey("userToken")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueBackToTaskList"{
            let destView = segue.destinationViewController as! TasksViewController
            
            destView.listID = currentList
        }
    }
}
