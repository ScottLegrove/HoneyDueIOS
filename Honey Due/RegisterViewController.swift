//
//  RegisterViewController.swift
//  Honey Due
//
//  Created by Tech on 2016-04-13.
//  Copyright © 2016 Scott Legrove. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController{
    
    @IBOutlet weak var inputUserName: UITextField!
    @IBOutlet weak var inputUserEmail: UITextField!
    @IBOutlet weak var inputUserPassword: UITextField!
    @IBOutlet weak var inputConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func submitRegisterUser(sender: AnyObject) {
        
        
        if (inputUserName.text!.isEmpty || inputUserPassword.text!.isEmpty || inputUserEmail.text!.isEmpty || inputConfirmPassword.text!.isEmpty){
            let alertController = UIAlertController(title: "Missing Fields", message: "Please re-enter credentials", preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: "OK",  style: .Default){
                (_) in
            }
            
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true){}
        }else if inputUserPassword.text! != inputConfirmPassword.text!{
            let alertController = UIAlertController(title: "Passwords don't match", message: "Please re-enter credentials", preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: "OK",  style: .Default){
                (_) in
            }
            
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true){}

        }
        else{
            UserHelper.CreateUser(inputUserName.text!, password: inputUserPassword.text!, email: inputUserEmail.text!)
            
            let alertController = UIAlertController(title: "Account Registered", message: "Your account has been created", preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: "OK",  style: .Default){
                (_) in
                    self.navigationController?.popViewControllerAnimated(true)
            }
            
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true){}
            
        }
    }
    
    @IBAction func btnCancelReg(sender: AnyObject) {
        
    }
    
}

