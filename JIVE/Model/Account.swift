//
//  Account.swift
//  JIVE
//
//  Created by Lee Sheng Jin on 2018/11/28.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class Account: NSObject {
    var id: String?
    var username: String?
    var email: String?
    var auth_token: String?
    var phone: String?
    var gender: String?
    var birthdate: String?
    var reset_password_token: String?
    var reset_password_expires: String?
    var stream_key: String?
    var fb_user: Bool?
    
    init? (_ info: NSDictionary) {
        self.id = info.value(forKey: "id") as? String
        self.username = info.value(forKey: "username") as? String
        self.email = info.value(forKey: "email") as? String
        self.auth_token = info.value(forKey: "auth_token") as? String
        self.phone = info.value(forKey: "phone") as? String
        self.gender = info.value(forKey: "gender") as? String
        self.birthdate = info.value(forKey: "birthdate") as? String
        self.reset_password_token = info.value(forKey: "reset_password_token") as? String
        self.reset_password_expires = info.value(forKey: "reset_password_expires") as? String
        self.stream_key = info.value(forKey: "stream_key") as? String
        self.fb_user = info.value(forKey: "fb_user") as? Bool ?? false
    }
    
    func getAllFields() -> NSDictionary {
        return [
            "id" : self.id ?? "",
            "username": self.username ?? "",
            "email": self.email ?? "",
            "auth_token": self.auth_token ?? "",
            "phone": self.phone ?? "",
            "gender": self.gender ?? "",
            "birthdate": self.birthdate ?? "",
            "reset_password_token": self.reset_password_token ?? "",
            "reset_password_expires": self.reset_password_expires ?? "",
            "stream_key": self.stream_key ?? "",
            "fb_user": self.fb_user ?? false
        ]
    }
    
    func getDic() -> NSDictionary {
        return [
            "id" : self.id ?? "",
            "username": self.username ?? "",
            "email": self.email ?? "",
            "phone": self.phone ?? "",
            "gender": self.gender ?? "",
            "birthdate": self.birthdate ?? ""
        ]
    }
}
