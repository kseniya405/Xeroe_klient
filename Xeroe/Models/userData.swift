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
    static  var access_token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC94ZXJvZS5raW5lY3QucHJvOjgwOTFcL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE1NjUxMDAxMTgsImV4cCI6MTU2NTE4NjUxOCwibmJmIjoxNTY1MTAwMTE4LCJqdGkiOiJWSHZ0TmZnc1dZdUszZUZGIiwic3ViIjoxLCJwcnYiOiIxM2U4ZDAyOGIzOTFmM2I3YjYzZjIxOTMzZGJhZDQ1OGZmMjEwNzJlIiwic2NvcGVzIjpbImNsaWVudCJdfQ.sAiX8TH4xgqN5zbs5D4lBemkKvbZPKBGbNleNYxNvGE"
    static  let expires_in = 86400
    static  let token_type = "Bearer"
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
