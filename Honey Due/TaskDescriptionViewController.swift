//
//  ViewTaskViewController.swift
//  Honey Due
//
//  Created by Tech on 2016-04-13.
//  Copyright © 2016 Scott Legrove. All rights reserved.
//

import UIKit

class TaskDescriptionViewController: UIViewController{
    
    var currentTask: Int?
    var currentList: Int?
    var taskObj: ListItem?
    var uPrefs:NSUserDefaults?;
    var uToken: String?

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblCompletionDate: UILabel!
    @IBOutlet weak var lblCompleteStatus: UILabel!
    
    @IBAction func btnMarkComplete(sender: AnyObject) {
        taskObj = ListItemHelper.GetListItem(currentList!, taskId: currentTask!, uToken: uToken!)
        ListItemHelper.UpdateListItem(currentList!, taskID: currentTask!, title: (taskObj?.tTitle)!, content: (taskObj?.tDescription)!, dueDate: taskObj?.tDate, complete: true, token: uToken!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uPrefs = NSUserDefaults.standardUserDefaults()
        uToken = uPrefs!.stringForKey("userToken")
        
        taskObj = ListItemHelper.GetListItem(currentList!, taskId: currentTask!, uToken: uToken!)
        
        lblTitle.text = taskObj!.tTitle
        lblDescription.text = taskObj!.tDescription
        if let date = taskObj!.tDate
        {
            lblCompletionDate.text = String(date)
        }
        
        if taskObj?.tComplete == true{
            lblCompleteStatus.text = "Completed"
        }else{
            lblCompleteStatus.text = "Incomplete"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

