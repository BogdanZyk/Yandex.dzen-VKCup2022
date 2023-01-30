//
//  Post.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 30.01.2023.
//

import Foundation



struct Post: Identifiable{
    var id = UUID()
    var text: String
    var imageUrl: String?
    var podcastAudio: Audio
    var userInfo: UserInfo
    
    
    
    struct UserInfo{
        var fullName: String
        var avatar: String
    }
}
