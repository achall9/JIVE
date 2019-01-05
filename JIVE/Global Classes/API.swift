//
//  API.swift
//  TestApp
//
//  Created by RSS on 4/1/18.
//  Copyright © 2018 HTK. All rights reserved.
//

import UIKit
import Alamofire

class API: NSObject {
    class var sharedInstance : API {
        struct Static {
            static let instance : API = API()
        }
        return Static.instance
    }
    
    var headers = ["Content-Type": "application/json"]
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func login(_ param: [String: Any], completion: @escaping (_ errMsg: String?) -> Void) {
        Alamofire.request(APIURL.login, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            if response.result.isSuccess {
                let info = response.result.value as! NSDictionary
                if info.value(forKey: "userAccount") != nil {
                    User.sharedInstance.loadUserInfo(info)
                    self.appDelegate.saveUser()
                    completion(nil)
                }else {
                    completion("Email or Password is invalid. Please try again later.")
                }
            }else {
                completion(response.result.error?.localizedDescription)
            }
        }
    }
   
    func register(_ param: [String: Any], completion: @escaping (_ errMsg: String?) -> Void) {
        
        Alamofire.request(APIURL.register, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            if response.result.isSuccess {
                
                let info = response.result.value as! NSDictionary
                
                if info.value(forKey: "userAccount") != nil {
                    User.sharedInstance.loadUserInfo(info)
                    self.appDelegate.saveUser()
                    completion(nil)
                }else {
                    completion((info.value(forKeyPath: "errors.User") as! NSArray)[0] as? String)
                }
            }else {
                completion(response.result.error?.localizedDescription)
            }
        }
    }
    
    func updateUser(_ userId: String, completion: @escaping (_ errMsg: String?) -> Void) {
        let header: HTTPHeaders = ["Content-type" : "application/json", "Authorization": User.sharedInstance.account?.auth_token ?? ""]
        Alamofire.request(APIURL.updateUser.appending(userId), method: .put, parameters: (User.sharedInstance.getDic() as! [String: Any]), encoding: JSONEncoding.default, headers: header).responseJSON { response in
            
            if response.result.isSuccess {
                let info = response.result.value as! NSDictionary
                if info.value(forKey: "errors") == nil {
                    self.appDelegate.saveUser()
                    completion(nil)
                }else {
                    completion("Same username or email already exists. Please try again with new name.")
                }
            }else {
                completion(response.result.error?.localizedDescription)
            }
        }
    }
    
    func forgotPassword(_ email: String, completion: @escaping (_ errMsg: String?) -> Void) {
        let param: [String: Any] = [
            "email": email
        ]
        let header: HTTPHeaders = ["Content-type" : "application/json", "Authorization": User.sharedInstance.account?.auth_token ?? ""]
        Alamofire.request(APIURL.forgotPassword, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            
            if response.result.isSuccess {
                
                completion(nil)
                
            }else {
                completion(response.result.error?.localizedDescription)
            }
        }
    }
    
    func updatePassword(_ param: [String: Any], _ userId: String, completion: @escaping (_ errMsg: String?) -> Void) {
        let header: HTTPHeaders = ["Content-type" : "application/json", "Authorization": User.sharedInstance.account?.auth_token ?? ""]
        Alamofire.request(APIURL.updatePassword.appending(userId), method: .put, parameters: param, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            
            if response.result.isSuccess {
                let info = response.result.value as! NSDictionary
                if info.value(forKey: "errors") == nil {
                    completion(nil)
                }else {
                    completion("Old password is incorrect.")
                }
            }else {
                completion(response.result.error?.localizedDescription)
            }
        }
    }
    
    func uploadImage(_ imgData: Data, completion: @escaping (_ errMsg: String?) -> Void) {
        let param: [String: Any] = [
            "filename": "\(Date().timeIntervalSince1970).jpg",
            "imgType": "profile_pic"
        ]
//        let header: HTTPHeaders = ["Content-type" : "undefined", "Authorization": User.sharedInstance.account?.auth_token ?? ""]
        let header: HTTPHeaders = ["Authorization": User.sharedInstance.account?.auth_token ?? ""]
        Alamofire.request(APIURL.uploadImage, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            
            if response.result.isSuccess {
                
                let info = response.result.value as! NSDictionary
                let signedUrl: String = info.value(forKey: "signedUrl") as! String
                let path: String = info.value(forKey: "path") as! String
                
                let url = URL(string: signedUrl)!
                var request = URLRequest(url: url)
                request.setValue("undefined", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "PUT"
                request.httpBody = imgData
                let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    guard let _ = data, error == nil else {
                        print(error?.localizedDescription ?? "")
                        return
                    }
                    completion(path)
                })
                task.resume()                
            }else {
                completion(response.result.error?.localizedDescription)
            }
        }
    }
    
    func getFollowers(_ userId: String, completion: @escaping (_ errMsg: String?) -> Void) {
        let header: HTTPHeaders = ["Content-type" : "application/json", "Authorization": User.sharedInstance.account?.auth_token ?? ""]
        Alamofire.request(APIURL.getFollowers.appending(userId), method: .put, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            
            if response.result.isSuccess {
                
//                let info = response.result.value as! NSDictionary
                
                completion(nil)
                
            }else {
                completion(response.result.error?.localizedDescription)
            }
        }
    }
    
    func getFollowing(_ userId: String, completion: @escaping (_ errMsg: String?) -> Void) {
        let header: HTTPHeaders = ["Content-type" : "application/json", "Authorization": User.sharedInstance.account?.auth_token ?? ""]
        Alamofire.request(APIURL.getFollowing.appending(userId), method: .put, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            
            if response.result.isSuccess {
                
                //let info = response.result.value as! NSDictionary
                
                completion(nil)
                
            }else {
                completion(response.result.error?.localizedDescription)
            }
        }
    }
    
}
