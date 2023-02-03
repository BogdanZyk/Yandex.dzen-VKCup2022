//
//  PostView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 30.01.2023.
//

import SwiftUI

struct PostView: View {
    let post: Post
    @EnvironmentObject var rootVM: RootViewModel
    @EnvironmentObject var playerManager: AudioPlayerManger
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            postHeader
            postTextContent
            storySection
            postImage
            podcastSectionView
            //linkPreview
            postInfo
            postActionSection
        }
        .foregroundColor(.white)
        .padding()
        .hLeading()
        .background(Color.secondaryGray)
        .cornerRadius(20)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.primaryBg
            PostView(post: Mocks.posts[0])
        }
        .environmentObject(AudioPlayerManger())
        .environmentObject(RootViewModel())
    }
}


extension PostView{
    private var postHeader: some View{
        HStack{
            HStack(spacing: 15){
                NukeLazyImage(strUrl: post.channelInfo.avatar)
                    .clipShape(Circle())
                    .frame(width: 46, height: 46)
                VStack(alignment: .leading, spacing: 2){
                    Text(post.channelInfo.name)
                        .font(.system(size: 16).weight(.medium))
                        
                    Text("28K подписчиков")
                        .font(.system(size: 14).weight(.light))
                }
            }
            Spacer()
            Text("Подписаться")
                .font(.subheadline.bold())
                .foregroundColor(.accentColor)
        }
        
    }
    
    private var postTextContent: some View{
        VStack(alignment: .leading, spacing: 10){
            Text(post.text)
                .lineSpacing(3.5)
                .lineLimit(6)
                .font(.system(size: 16, weight: .medium))
        }
    }
    
    @ViewBuilder
    private var podcastSectionView: some View{
        if let podcast = post.podcastAudio{
            AudioPodcastViewComponent(playerManager: playerManager, podcast: podcast)
                .padding(.vertical, 10)
        }
    }
    
    @ViewBuilder
    private var postImage: some View{
        if let image = post.imageUrl{
            NukeLazyImage(strUrl: image)
                .padding(.horizontal, -16)
                .frame(height: 200)
        }
    }
    
    private var linkPreview: some View{
        HStack(alignment: .top, spacing: 16){
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.gray)
                .frame(width: 65, height: 65)
            VStack(alignment: .leading, spacing: 10){
                Text("Игра в кальмара - новый хит на Нетфликс, но какие идеи прес...")
                    .font(.system(size: 14, weight: .medium))
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
                Text("vox.com")
                    .font(.system(size: 14, weight: .light))
            }
        }
    }
    
    private var postInfo: some View{
        HStack{
            Text("1 день назад")
        }
        .font(.system(size: 14, weight: .medium))
        .foregroundColor(.lightGray)
    }
    
    
    private var postActionSection: some View{
        HStack(spacing: 15){
            Label {
                Text("1,3K")
                    .font(.system(size: 14))
                    .foregroundColor(.lightGray)
            } icon: {
                Image("like")
            }

            
            Image("chatBubble")
            Image("arrowShare")
            Spacer()
            
            Label {
                Text("23")
                    .font(.system(size: 14))
                    .foregroundColor(.lightGray)
            } icon: {
                Image("like")
                    .rotationEffect(.degrees(180))
            }
        }
    }
}


extension PostView{
    
    @ViewBuilder
    private var storySection: some View{
        if !post.stories.isEmpty, let preview = post.storyPreview{
            PostStorySectionView(rootVM: rootVM, preview: preview, stories: post.stories)
        }
    }
}
