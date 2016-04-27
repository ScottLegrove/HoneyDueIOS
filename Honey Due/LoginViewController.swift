//
//  LoginViewController.swift
//  Honey Due
//
//  Created by Tech on 2016-04-13.
//  Copyright © 2016 Scott Legrove. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{
    
    @IBOutlet weak var inputUsername: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    var uPrefs:NSUserDefaults?;
    
    @IBAction func onClick(sender: UIButton) {
        if sender.tag == 0{

            
            if !inputPassword.text!.isEmpty && !inputUsername.text!.isEmpty{
                let uName = inputUsername.text!;
                let uPass = inputPassword.text!;
                let validLogin = UserHelper.Login(uName, uPass: uPass);
                
                if validLogin != nil {
                    
                    
                    uPrefs!.setValue(validLogin, forKey: "userToken")
                    let didSave = uPrefs!.synchronize()
                    if !didSave{
                        let alertController = UIAlertController(title: "Failed Login", message: "Please re-enter credentials", preferredStyle: .Alert)
                        
                        let okAction = UIAlertAction(title: "OK",  style: .Default){
                            (_) in
                        }
                        
                        alertController.addAction(okAction)
                        self.presentViewController(alertController, animated: true){}
                    }
                   
                    self.performSegueWithIdentifier("segueToLists", sender: self)
                   return
                }
                
            }
        }
            let alertController = UIAlertController(title: "Invalid Login", message: "Please re-enter credentials", preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: "OK",  style: .Default){
                (_) in
            }
            
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true){ }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uPrefs = NSUserDefaults.standardUserDefaults()
        

        // Clear Token 
         

    }
    
    override func viewDidAppear(animated: Bool) {
        let token = uPrefs!.stringForKey("userToken");
        
        if token != nil {
            self.performSegueWithIdentifier("segueToLists", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
    
}