//
//  RootViewModel.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 01.02.2023.
//

import SwiftUI


///Тестовый класс корневого вью с состояниями

class RootViewModel: ObservableObject{
    
    @Published var posts = Mocks.posts
    @Published var currentTab: TabEnum = .home
    @Published var selectedStories = [Story]()
    @Published var showStoryView: Bool = false
    @Published var showPostCreateView: Bool = false
    
    
    
    ///создание тестового поста с текстом или подкастом
    func createPost(_ text: String, podcast: Podcast?){
        let post = Post(text: text, imageUrl: nil, podcastAudio: podcast, channelInfo: .init(name: "Aнтон Лавров", avatar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQo6rHdhb-HpWoC8JKiBBOSv376q3Z49BvUxdwdpdAwvaLiuTH9sXEECwMyQ00dQxnAYFA&usqp=CAU"))
        withAnimation {
            posts.insert(post, at: 0)
        }
        showPostCreateView.toggle()
    }
}
