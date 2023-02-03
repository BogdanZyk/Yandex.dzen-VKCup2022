//
//  ListElementsView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 03.02.2023.
//

import SwiftUI

struct ListElementsView: View {
    @EnvironmentObject var rootVM: RootViewModel
    @EnvironmentObject var player: AudioPlayerManger
    var body: some View {
        NavigationView {
            List {
                Section {
                    multiplyElementsSection
                } header: {
                    Text("Лента элементов")
                }

                Section {
                    singleElementsSection
                } header: {
                    Text("Одиночные элементы")
                }
            }
            .navigationTitle("Интерактивные элементы")
            .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(.dark)
    }
}

struct ListElementsView_Previews: PreviewProvider {
    static var previews: some View {
        ListElementsView()
            .environmentObject(AudioPlayerManger())
            .environmentObject(RootViewModel())
    }
}

extension ListElementsView{
    private var singleElementsSection: some View{
        Group{
            NavigationLink("История") {
                if let post = Mocks.posts.first(where: {!($0.stories.isEmpty)}), let preview = post.storyPreview{
                    PostStorySectionView(rootVM: rootVM, preview: preview, stories: post.stories)
                        .padding()
                }
            }
            NavigationLink("Подкаст") {
                if let podcast = Mocks.posts.compactMap({$0.podcastAudio}).first{
                    AudioPodcastViewComponent(playerManager: player, podcast: podcast)
                        .padding()
                }
            }
        }
    }
    
    private var multiplyElementsSection: some View{
        Group{
            NavigationLink("Истории") {
                ScrollView{
                    VStack(spacing: 30){
                        ForEach(Mocks.posts.filter({!($0.stories.isEmpty)})) { post in
                            PostStorySectionView(rootVM: rootVM, preview: post.storyPreview ?? .init(title: "", image: ""), stories: post.stories)
                        }
                    }
                    .padding()
                }
            }
            NavigationLink("Подкасты") {
                ScrollView{
                    VStack(spacing: 30){
                        if let podcasts = Mocks.posts.compactMap({$0.podcastAudio}){
                            ForEach(podcasts, id: \.id) { podcast in
                                AudioPodcastViewComponent(playerManager: player, podcast: podcast)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}
