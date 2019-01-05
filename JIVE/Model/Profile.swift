//
//  Profile.swift
//  JIVE
//
//  Created by Lee Sheng Jin on 2018/11/28.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class Profile: NSObject {
    var user_id: String?
    var username: String?
    var name: String?
    var currently_live: Bool?
    var stripe_id: String?
    var bio: String?
    var status: String?
    var profile_pic: String?
    var cover_photo: String?
    var facebook_link: String?
    var instagram_link: String?
    var twitter_link: String?
    var spotify_link: String?
    var soundcloud_link: String?
    var apple_music_link: String?
    var bandcamp_link: String?
    var notification_subscription: String?
    var has_streamed: Bool?
    var notification_status: Int?
    
    init? (_ info: NSDictionary) {
        self.user_id = info.value(forKey: "user_id") as? String
        self.username = info.value(forKey: "username") as? String
        self.name = info.value(forKey: "name") as? String
        self.currently_live = info.value(forKey: "currently_live") as? Bool
        self.stripe_id = info.value(forKey: "stripe_id") as? String
        self.bio = info.value(forKey: "bio") as? String
        self.status = info.value(forKey: "status") as? String
        self.profile_pic = info.value(forKey: "profile_pic") as? String
        self.cover_photo = info.value(forKey: "cover_photo") as? String
        self.facebook_link = info.value(forKey: "facebook_link") as? String
        self.instagram_link = info.value(forKey: "instagram_link") as? String
        self.twitter_link = info.value(forKey: "twitter_link") as? String
        self.spotify_link = info.value(forKey: "spotify_link") as? String
        self.soundcloud_link = info.value(forKey: "soundcloud_link") as? String
        self.apple_music_link = info.value(forKey: "apple_music_link") as? String
        self.bandcamp_link = info.value(forKey: "bandcamp_link") as? String
        self.notification_subscription = info.value(forKey: "notification_subscription") as? String
        self.has_streamed = info.value(forKey: "has_streamed") as? Bool
        self.notification_status = info.value(forKey: "notification_status") as? Int ?? 0
    }
    
    func getAllFields() -> NSDictionary {
        return [
            "user_id": self.user_id ?? "",
            "username": self.username ?? "",
            "name": self.name ?? "",
            "currently_live": self.currently_live ?? false,
            "stripe_id": self.stripe_id ?? "",
            "bio": self.bio ?? "",
            "status": self.status ?? "",
            "profile_pic": self.profile_pic ?? "",
            "cover_photo": self.cover_photo ?? "",
            "facebook_link": self.facebook_link ?? "",
            "instagram_link": self.instagram_link ?? "",
            "twitter_link": self.twitter_link ?? "",
            "spotify_link": self.spotify_link ?? "",
            "soundcloud_link": self.soundcloud_link ?? "",
            "apple_music_link": self.apple_music_link ?? "",
            "bandcamp_link": self.bandcamp_link ?? "",
            "notification_subscription": self.notification_subscription ?? "",
            "has_streamed": self.has_streamed ?? false,
            "notification_status": self.notification_status ?? 0
        ]
    }
    
    func getDic() -> NSDictionary {
        return [
            "user_id": self.user_id ?? "",
            "username": self.username ?? "",
            "name": self.name ?? "",
            "bio": self.bio ?? "",
            "status": self.status ?? "",
            "profile_pic": self.profile_pic ?? "",
            "cover_photo": self.cover_photo ?? "",
            "facebook_link": self.facebook_link ?? "",
            "instagram_link": self.instagram_link ?? "",
            "twitter_link": self.twitter_link ?? "",
            "spotify_link": self.spotify_link ?? "",
            "soundcloud_link": self.soundcloud_link ?? "",
            "apple_music_link": self.apple_music_link ?? "",
            "bandcamp_link": self.bandcamp_link ?? ""
        ]
    }
}
