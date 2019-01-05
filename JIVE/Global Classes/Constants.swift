//
//  Constants.swift
//  JIVE
//
//  Created by Lee Sheng Jin on 2018/11/28.
//  Copyright © 2018 LOVI. All rights reserved.
//
let baseURL: String = "https://api.jive.live/api/"
let baseAmazonURL: String = "https://s3-us-west-1.amazonaws.com/"
struct APIURL {
    static let login = baseURL.appending("login")
    static let register = baseURL.appending("register")
    static let updateUser = baseURL.appending("user/update/")
    static let getUserAccount = baseURL.appending("userAccount/")
    static let getUserProfile = baseURL.appending("userProfile/")
    static let getCurrentUser = baseURL.appending("user")
    static let uploadImage = baseURL.appending("uploadImage")
    static let forgotPassword = baseURL.appending("forgot")
    static let updatePassword = baseURL.appending("updatePassword/")
    static let getFollowers = baseURL.appending("followers/")
    static let getFollowing = baseURL.appending("following/")
}
