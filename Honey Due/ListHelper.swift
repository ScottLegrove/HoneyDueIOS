//
//  ListHelper.swift
//  asdf
//
//  Created by Tech on 2016-04-12.
//  Copyright © 2016 GBC. All rights reserved.
//

import Foundation

class ListHelper {
    static func CreateList(lTitle:String, uToken:String)->Bool{
        let data = APIConsumer.AddListJson(lTitle, token: uToken);
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
    
    static func GetLists(uToken:String)->Array<List>?{
        let data = APIConsumer.GetListsJson(uToken);
        let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []);
        var lists = Array<List>();
        
        if json?.count > 0 {
            if let list = json!["lists"] as? [[String : AnyObject]]
            {
                for i in list{
                    lists.append(List(id: Int(i["id"] as! String)!, title: i["title"] as! String));
                }
                
                return lists;
            }
        }
        
        return nil;
    }
    
    static func GetList(lId:Int, uToken:String)->List?{
        let data = APIConsumer.GetListJson(lId, token:uToken);
        let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []);
        
        if json?.count > 0 {
            if let list = json!["list"] as? [String : AnyObject]{
                return List(id: Int(list["id"] as! String)!, title: list["title"] as! String);
            }
        }
        
        return nil;
    }
    
    static func DeleteList(listId:Int, uToken:String)->Bool{
        let data = APIConsumer.DeleteListJson(listId, token:uToken);
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