//
//  Task.swift
//  asdf
//
//  Created by Tech on 2016-04-12.
//  Copyright © 2016 GBC. All rights reserved.
//

import UIKit

class ListItem {
    let tId:Int;
    let tTitle:String;
    let tDescription:String;
    let tDate:NSDate?;
    let tComplete:Bool;
    
    init(id:Int, title:String, description:String, date:NSDate?, complete:Bool=false){
        self.tId = id;
        self.tTitle = title;
        self.tDescription = description;
        self.tDate = date;
        self.tComplete = complete;
    }
}
