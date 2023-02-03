//
//  Post.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 30.01.2023.
//

import Foundation


// Примерная модель поста
/// Включает в себя
/// Текст поста
/// Изображени
/// Подкаст
/// Истории
/// Превью истории


struct Post: Identifiable{
    var id = UUID()
    let text: String
    var imageUrl: String?
    var podcastAudio: Podcast?
    let channelInfo: ChannelInfo
    var stories: [Story] = []
    var storyPreview: StoryPreview?
    
    
    struct ChannelInfo{
        var name: String
        var avatar: String
    }
    
    struct StoryPreview{
        let title: String
        let image: String
    }
}


struct Podcast{
    var id = UUID()
    var audio: Audio
    var channelName: String
}
