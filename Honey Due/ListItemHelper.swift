//
//  TaskHelper.swift
//  asdf
//
//  Created by Tech on 2016-04-12.
//  Copyright © 2016 GBC. All rights reserved.
//

import UIKit

class ListItemHelper {
    static func CreateListItem(listID:Int, title:String, content:String, dueDate:NSDate?, token:String) -> Bool{
        let data = APIConsumer.AddListItemJson(listID, title: title, content: content, dueDate: dueDate, token: token);
        let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []);
        
        if json?.count > 0 {
            if let result = json!["success"] as! Bool?
            {
                return result
            }
            return false
        }
        
        return false;
    }
    
    static func UpdateListItem(listID:Int, taskID: Int, title:String, content:String, dueDate:NSDate?, complete: Bool?, token:String) -> Bool{
        let data = APIConsumer.UpdateListItemJson(listID, itemId: taskID, title: title, content: content, dueDate: dueDate, complete: complete, token: token);
        let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []);
        
        if json?.count > 0 {
            if let result = json!["success"] as! Bool?
            {
                return result
            }
            return false
        }
        
        return false;
    }
    
    static func GetListItems(lId:Int, uToken:String)->Array<ListItem>?{
        let data = APIConsumer.GetListItemsJson(lId, token:uToken);
        let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []);
        var tasks = Array<ListItem>();
        
        if json?.count > 0 {
            if let task = json!["items"] as? [[String : AnyObject]]{
                let dateFormatter = NSDateFormatter();
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss";
                dateFormatter.timeZone = NSTimeZone(name: "UTC");
                
                for i in task {
                    var actualDate : NSDate?;
                    if let dateString = i["dueDate"] as? String{
                        actualDate = dateFormatter.dateFromString(dateString);
                    }
                    
                    
                    tasks.append(ListItem(id: Int(i["id"] as! String)!, title: i["title"] as! String, description: i["content"] as! String, date: actualDate, complete: i["complete"] as! Bool));
                }
                
                return tasks;
            }
        }
        
        return nil;
    }
    
    static func GetListItem(listId:Int, taskId:Int, uToken:String)->ListItem?{
        let data = APIConsumer.GetListItemJson(listId, itemId: taskId, token: uToken);
        let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []);
        
        if json?.count == 6 {
            let dateFormatter = NSDateFormatter();
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss";
            dateFormatter.timeZone = NSTimeZone(name: "UTC");

            var actualDate : NSDate?;
            if let dateString = json!["dueDate"] as? String{
                actualDate = dateFormatter.dateFromString(dateString);
            }
                
            return ListItem(id: Int(json!["id"] as! String)!, title: json!["title"] as! String, description: json!["content"] as! String, date: actualDate, complete: json!["complete"] as! Bool);
        }
        
        return nil;
    }
    
    
    static func DeleteListItem(listId:Int, taskId:Int, uToken:String)->Bool{
        let data = APIConsumer.DeleteListItemJson(listId, itemId:taskId, token:uToken);
        let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []);
        
        if json?.count > 0 {
            if let result = json!["success"] as! Bool?
            {
                return result
            }
            return false
        }
        
        return false;
    }
}
