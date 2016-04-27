//
//  ListsViewController.swift
//  Honey Due
//
//  Created by Tech on 2016-04-13.
//  Copyright © 2016 Scott Legrove. All rights reserved.
//

import UIKit
import Darwin

class ListsViewController: UITableViewController{
    var uToken: String?
    var listArray: Array<List>?
    var uPrefs: NSUserDefaults?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uToken = NSUserDefaults.standardUserDefaults().stringForKey("userToken")
        listArray = ListHelper.GetLists(uToken!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("segueToListOfTasks", sender: self)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray!.count
    }
    
    @IBAction func btnLogOut(sender: AnyObject) {
        uPrefs = NSUserDefaults.standardUserDefaults()
        uPrefs!.removeObjectForKey("userToken");
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
      
        let cell = tableView.dequeueReusableCellWithIdentifier("listCell");
        
        cell!.textLabel?.text = listArray![indexPath.row].lTitle;
        
        return cell!;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToListOfTasks" {
            if let destination = segue.destinationViewController as? TasksViewController {
                if let selectedRow = tableView.indexPathForSelectedRow?.row {
                    destination.listID = listArray![selectedRow].lId
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            ListHelper.DeleteList(listArray![indexPath.row].lId, uToken: uToken!)
            self.listArray = ListHelper.GetLists(self.uToken!)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func btnAddNewList(sender: AnyObject) {
        addNewList()
    }
    
    func addNewList(){
        let alertController = UIAlertController(title: "Add New List", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: {
            alert -> Void in
            let inputTitle = alertController.textFields![0] as UITextField
            ListHelper.CreateList(inputTitle.text!, uToken: self.uToken!)
            self.listArray = ListHelper.GetLists(self.uToken!)
            self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            textField.placeholder = "Title"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
