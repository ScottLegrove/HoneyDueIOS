//
//  User.swift
//  asdf
//
//  Created by Tech on 2016-04-12.
//  Copyright © 2016 GBC. All rights reserved.
//

import Foundation

class User {
    let uName:String;
    let uToken:String;
    
    init(name:String, token:String){
        self.uName = name;
        self.uToken = token;
    }
}

class OtherUser {
    let uName: String;
    let uId: Int;
    
    init(name:String, id:Int) {
        self.uId = id;
        self.uName = name;
    }
}