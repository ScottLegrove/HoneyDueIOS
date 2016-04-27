//
//  APIConsumer.swift
//  asdf
//
//  Created by Tech on 2016-04-12.
//  Copyright © 2016 GBC. All rights reserved.
//

import UIKit

class APIConsumer {
    private static let MASTER_ENDPOINT = "http://honeydew.pragmaticdevelopment.net";
    private static let LOGIN_ENDPOINT_SUFFIX = "/login";
    private static let LISTS_ENDPOINT_SUFFIX = "/lists";
    private static let LISTS_I_ENDPOINT_SUFFIX = "/lists/%d";
    private static let LISTS_I_USERS_ENDPOINT_SUFFIX = "/lists/%d/users";
    private static let LISTS_I_USERS_I_ENDPOINT_SUFFIX = "/lists/%d/users/%d";
    private static let LISTS_I_ITEMS_ENDPOINT_SUFFIX = "/lists/%d/items";
    private static let LISTS_I_ITEMS_I_ENDPOINT_SUFFIX = "/lists/%d/items/%d";
    
    var data = NSMutableData()
    
    private static func DoRequest(request: NSURLRequest) -> NSData{
        let session = NSURLSession.sharedSession()
        let semaphore: dispatch_semaphore_t = dispatch_semaphore_create(0)
        
        var data: NSData?
        
        let task = session.dataTaskWithRequest(request, completionHandler: {taskData,_,error in
            data = taskData;
            dispatch_semaphore_signal(semaphore);
            }
        )
        
        task.resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        return data!;
    }
    
    static func GetRegisterJson(username:String, password: String, email: String) -> NSData
    {
        let query = String(format: "%@%@", MASTER_ENDPOINT, LOGIN_ENDPOINT_SUFFIX)
        let url =  NSURL(string: query)
        let request = NSMutableURLRequest(URL: url!)
        
        let encodedUsername = username.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        let encodedPassword = password.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        let encodedEmail = email.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        
        request.HTTPMethod = "POST";
        request.HTTPBody = String(format: "username=%@&password=%@&email=%@", encodedUsername!, encodedPassword!, encodedEmail!).dataUsingEncoding(NSUTF8StringEncoding)
        
        return DoRequest(request)
    }
    
    static func GetLoginJson(username:String, password: String) -> NSData
    {
        let encodedUsername = username.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        let encodedPassword = password.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        
        let query = String(format: "%@%@?username=%@&password=%@", MASTER_ENDPOINT, LOGIN_ENDPOINT_SUFFIX, encodedUsername!, encodedPassword!)
        
        let url =  NSURL(string: query)
        let request = NSMutableURLRequest(URL: url!)
        
        return DoRequest(request)
    }
    
    static func AddListJson(title: String, token: String) -> NSData
    {
        let query = String(format: "%@%@", MASTER_ENDPOINT, LISTS_ENDPOINT_SUFFIX)
        let url =  NSURL(string: query)
        let request = NSMutableURLRequest(URL: url!)
        
        let encodedTitle = title.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        let encodedToken = token.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        
        request.addValue(encodedToken!, forHTTPHeaderField: "X-Token")
        
        request.HTTPMethod = "POST";
        request.HTTPBody = String(format: "title=%@", encodedTitle!).dataUsingEncoding(NSUTF8StringEncoding)
        
        return DoRequest(request)
    }
    
    static func GetListsJson(token: String) -> NSData
    {
        let query = String(format: "%@%@", MASTER_ENDPOINT, LISTS_ENDPOINT_SUFFIX)
        let url =  NSURL(string: query)
        let request = NSMutableURLRequest(URL: url!)
        
        let encodedToken = token.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        
        request.addValue(encodedToken!, forHTTPHeaderField: "X-Token")
        
        return DoRequest(request)
    }
    
    static func GetListJson(listId: Int, token: String) -> NSData
    {
        var query = String(format: "%@%@", MASTER_ENDPOINT, LISTS_I_ENDPOINT_SUFFIX)
        query = String(format: query, listId)
        
        let url =  NSURL(string: query)
        let request = NSMutableURLRequest(URL: url!)
        
        let encodedToken = token.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        
        request.addValue(encodedToken!, forHTTPHeaderField: "X-Token")
        
        return DoRequest(request)
    }
    
    static func DeleteListJson(listId: Int, token: String) -> NSData
    {
        var query = String(format: "%@%@", MASTER_ENDPOINT, LISTS_I_ENDPOINT_SUFFIX)
        query = String(format: query, listId)
        
        let url =  NSURL(string: query)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "DELETE";
        
        let encodedToken = token.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        
        request.addValue(encodedToken!, forHTTPHeaderField: "X-Token")
        
        return DoRequest(request)
    }
    
    static func AddListItemJson(listId: Int, title: String, content: String, dueDate: NSDate?, token: String) -> NSData
    {
        var query = String(format: "%@%@", MASTER_ENDPOINT, LISTS_I_ITEMS_ENDPOINT_SUFFIX)
        query = String(format: query, listId)
        
        let url =  NSURL(string: query)
        let request = NSMutableURLRequest(URL: url!)
        
        let encodedTitle = title.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        let encodedContent = content.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        
        let encodedToken = token.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        
        request.addValue(encodedToken!, forHTTPHeaderField: "X-Token")
        
        request.HTTPMethod = "POST";
        
        var body = String(format: "title=%@&content=%@", encodedTitle!, encodedContent!)
        
        if let date = dueDate
        {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "MM/dd/yyyy KK:mm:ss a Z"
            
            body += String(format: "&duedate=%@", formatter.stringFromDate(date))
        }
        
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        
        return DoRequest(request)
    }
    
    static func UpdateListItemJson(listId: Int, itemId: Int, title: String, content: String, dueDate: NSDate?, complete: Bool?, token: String) -> NSData
    {
        var query = String(format: "%@%@", MASTER_ENDPOINT, LISTS_I_ITEMS_I_ENDPOINT_SUFFIX)
        query = String(format: query, listId, itemId)
        
        let url =  NSURL(string: query)
        let request = NSMutableURLRequest(URL: url!)
        
        let encodedTitle = title.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        let encodedContent = content.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        
        let encodedToken = token.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        
        request.addValue(encodedToken!, forHTTPHeaderField: "X-Token")
        
        request.HTTPMethod = "PUT";
        
        var body = String(format: "title=%@&content=%@", encodedTitle!, encodedContent!)
        
        if let date = dueDate
        {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "MM/dd/yyyy KK:mm:ss a Z"
            
            body += String(format: "&duedate=%@", formatter.stringFromDate(date))
        }
        
        if let completeUnwrapped = complete
        {
            
            body += String(format: "&complete=%@", completeUnwrapped ? "true" : "false")
        }
        
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        
        return DoRequest(request)
    }
    
    static func GetListItemsJson(listId: Int, token: String) -> NSData
    {
        var query = String(format: "%@%@", MASTER_ENDPOINT, LISTS_I_ITEMS_ENDPOINT_SUFFIX)
        query = String(format: query, listId)
        
        let url =  NSURL(string: query)
        let request = NSMutableURLRequest(URL: url!)
        
        let encodedToken = token.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        
        request.addValue(encodedToken!, forHTTPHeaderField: "X-Token")
        
        return DoRequest(request)
    }
    
    static func GetListItemJson(listId: Int, itemId: Int, token: String) -> NSData
    {
        var query = String(format: "%@%@", MASTER_ENDPOINT, LISTS_I_ITEMS_I_ENDPOINT_SUFFIX)
        query = String(format: query, listId, itemId)
        
        let url =  NSURL(string: query)
        let request = NSMutableURLRequest(URL: url!)
        
        let encodedToken = token.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        
        request.addValue(encodedToken!, forHTTPHeaderField: "X-Token")
        
        return DoRequest(request)
    }
    
    static func DeleteListItemJson(listId: Int, itemId: Int, token: String) -> NSData
    {
        var query = String(format: "%@%@", MASTER_ENDPOINT, LISTS_I_ITEMS_I_ENDPOINT_SUFFIX)
        query = String(format: query, listId, itemId)
        
        let url =  NSURL(string: query)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "DELETE";
        
        let encodedToken = token.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        
        request.addValue(encodedToken!, forHTTPHeaderField: "X-Token")
        
        return DoRequest(request)
    }
    
    static func GetUsersJson(listId: Int, token: String) -> NSData
    {
        var query = String(format: "%@%@", MASTER_ENDPOINT, LISTS_I_USERS_ENDPOINT_SUFFIX)
        query = String(format: query, listId)
        
        let url =  NSURL(string: query)
        let request = NSMutableURLRequest(URL: url!)
        
        let encodedToken = token.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        
        request.addValue(encodedToken!, forHTTPHeaderField: "X-Token")
        
        return DoRequest(request)
    }
    
    static func GetUserJson(listId: Int, userId: Int, token: String) -> NSData
    {
        var query = String(format: "%@%@", MASTER_ENDPOINT, LISTS_I_USERS_I_ENDPOINT_SUFFIX)
        query = String(format: query, listId, userId)
        
        let url =  NSURL(string: query)
        let request = NSMutableURLRequest(URL: url!)
        
        let encodedToken = token.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        
        request.addValue(encodedToken!, forHTTPHeaderField: "X-Token")
        
        return DoRequest(request)
    }
    
    static func AddUserJson(listId: Int, username: String, token: String) -> NSData{
        var query = String(format: "%@%@", MASTER_ENDPOINT, LISTS_I_USERS_ENDPOINT_SUFFIX)
        query = String(format: query, listId)
        
        let url =  NSURL(string: query)
        let request = NSMutableURLRequest(URL: url!)
        
        
        let encodedUsername = username.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        let encodedToken = token.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        
        request.addValue(encodedToken!, forHTTPHeaderField: "X-Token")
        
        request.HTTPMethod = "POST";
        request.HTTPBody = String(format: "username=%@", encodedUsername!).dataUsingEncoding(NSUTF8StringEncoding)
        
        return DoRequest(request)
    }
    
    static func DeleteUserJson(listId: Int, userId: Int, token: String) -> NSData
    {
        var query = String(format: "%@%@", MASTER_ENDPOINT, LISTS_I_USERS_I_ENDPOINT_SUFFIX)
        query = String(format: query, listId, userId)
        
        let url =  NSURL(string: query)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "DELETE";
        
        let encodedToken = token.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        
        request.addValue(encodedToken!, forHTTPHeaderField: "X-Token")
        
        return DoRequest(request)
    }
}
