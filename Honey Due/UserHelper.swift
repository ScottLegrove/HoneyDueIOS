//
//  UserHelper.swift
//  asdf
//
//  Created by Tech on 2016-04-12.
//  Copyright © 2016 GBC. All rights reserved.
//

import Foundation

class UserHelper{
    static func Login(uName:String, uPass:String)->String?{
        let data = APIConsumer.GetLoginJson(uName, password:uPass);
        let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []);
        
        if let _ = json?["error"] as! String?{
            return nil
        }
        
        if (json?.count > 0) {
            return json!["token"] as? String;
        }
        
        return nil;
    }
    
    static func CreateUser(userName:String, password:String, email:String)->Bool{
        let data = APIConsumer.GetRegisterJson(userName, password: password, email: email);
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
    
    static func DeleteUser(listId: Int, userId: Int, token: String) -> Bool {
        let data = APIConsumer.DeleteUserJson(listId, userId: userId, token: token);
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
    
    static func AddUser(listId: Int, username: String, token: String) -> Bool {
        let data = APIConsumer.AddUserJson(listId, username: username, token: token);
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
    
    static func GetUser(listId: Int, userId: Int, token: String) -> OtherUser? {
        let data = APIConsumer.GetUserJson(listId, userId: userId, token: token);
        let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []);
        
        if json?.count == 2 {
            if let _ = json?["error"] as! String?{
                return nil
            }
            
            return OtherUser(name: json?["username"] as! String, id: Int(json?["id"] as! String)!);
        }
        
        return nil;
    }
    
    static func GetUsers(listId: Int, token: String) -> Array<OtherUser>? {
        let data = APIConsumer.GetUsersJson(listId, token: token);
        let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []);
        var users = Array<OtherUser>();
        
        if json?.count > 0 {
            if let user = json!["items"] as? [[String : AnyObject]]{
                for i in user {
                    users.append(OtherUser(name: i["username"] as! String, id: Int(i["id"] as! String)!));
                }
                
                return users;
            }
        }
        
        return nil;
    }
    
    
    
    func UpdateUser(){
        
    }
}