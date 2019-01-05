//
//  User.swift
//  JIVE
//
//  Created by Lee Sheng Jin on 2018/11/28.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class User: NSObject {
    class var sharedInstance: User {
        struct Static {
            static let instance: User = User()
        }
        return Static.instance
    }
    
    var account: Account?
    var profile: Profile?
    
    func loadUserInfo(_ info: NSDictionary) {
        self.account = Account(info.value(forKey: "userAccount") as! NSDictionary)
        self.profile = Profile(info.value(forKey: "userProfile") as! NSDictionary)
    }
    
    func getAllFields() -> NSDictionary {
        return [
            "userAccount": self.account?.getAllFields() as Any,
            "userProfile": self.profile?.getAllFields() as Any
        ]
    }
    
    func getDic() -> NSDictionary {
        return [
            "userAccount": self.account?.getDic() as Any,
            "userProfile": self.profile?.getDic() as Any
        ]
    }
    
    func initialize() {
        self.account = nil
        self.profile = nil
    }
}
