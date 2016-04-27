//
//  AddTaskViewController.swift
//  Honey Due
//
//  Created by C412IT44 on 2016-04-13.
//  Copyright © 2016 Scott Legrove. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController{
    
    @IBOutlet weak var inputDescription: UITextView!
    @IBOutlet weak var inputTitle: UITextField!
    @IBOutlet weak var inputDate: UIDatePicker!
    
    var currentList: Int?
    var uPrefs: NSUserDefaults?
    var uToken: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uPrefs = NSUserDefaults.standardUserDefaults()
        uToken = uPrefs!.stringForKey("userToken")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func submitTask(sender: AnyObject) {
        let title = inputTitle.text
        let desc = inputDescription.text
        let date = inputDate.date
        
        ListItemHelper.CreateListItem(currentList!, title: title!, content: desc, dueDate: date, token: uToken!)
        (self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 2] as! TasksViewController).taskArray = ListItemHelper.GetListItems(currentList!, uToken: uToken!)
        (self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 2] as! UITableViewController).tableView.reloadData()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueBackToTaskList"{
            let destView = segue.destinationViewController as! TasksViewController
            
            destView.listID = currentList
        }
    }
}
