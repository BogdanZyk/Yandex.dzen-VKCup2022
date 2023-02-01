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
    var podcastAudio: Podcast?
    var channelInfo: ChannelInfo
    var stories: [Story] = []
    
    
    
    struct ChannelInfo{
        var name: String
        var avatar: String
    }
}


struct Podcast{
    var id = UUID()
    var audio: Audio
    var channelName: String
}
