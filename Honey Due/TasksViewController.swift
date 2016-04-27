//
//  TasksViewController.swift
//  Honey Due
//
//  Created by Tech on 2016-04-13.
//  Copyright © 2016 GBC. All rights reserved.
//

import UIKit

class TasksViewController: UITableViewController{
    var taskArray: Array<ListItem>?
    var listID: Int?
    var uPrefs:NSUserDefaults?;
    var uToken: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uPrefs = NSUserDefaults.standardUserDefaults()
        uToken = uPrefs!.stringForKey("userToken")
        taskArray =  ListItemHelper.GetListItems(listID!, uToken: uToken!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("segueToTaskInfo", sender: self)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("taskCellID");
        cell!.textLabel?.text = taskArray![indexPath.row].tTitle
        
        return cell!
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            ListItemHelper.DeleteListItem(self.listID!, taskId: self.taskArray![indexPath.row].tId, uToken: self.uToken!)
            self.taskArray = ListItemHelper.GetListItems(self.listID!, uToken: self.uToken!)
            self.tableView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToTaskInfo" {
            let nextScene =  segue.destinationViewController as! TaskDescriptionViewController
            
            // Pass the selected object to the new view controller.
            if let indexPath = self.tableView.indexPathForSelectedRow?.row {
                let selectedTask = taskArray![indexPath].tId;
                
                nextScene.currentTask = selectedTask
                nextScene.currentList = listID
            }
        }
        
        if segue.identifier == "segueToAddNewTask"{
            let destView = segue.destinationViewController as! AddTaskViewController
            
            destView.currentList = listID
        }
        
        if segue.identifier == "segueToShare" {
            if let destination = segue.destinationViewController as? ShareListViewController {
                destination.currentList = listID
            }
        }
    }
}
