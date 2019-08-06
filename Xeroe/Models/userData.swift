//
//  NewUser.swift
//  Xeroe
//
//  Created by Денис Марков on 7/30/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation

class userData
{

var access_token: String?
var expires_in: String?
var token_type: String?
    
struct userData {
    static  var access_token: String?
    static  let expires_in = 86400
    static  let token_type = "bearer"
}
    
}
/*
 {
 "phone": "380661000000",
 "password": "password",
 "email": "example@gmail.com",
 "userable_type": "client"
 }
 */
