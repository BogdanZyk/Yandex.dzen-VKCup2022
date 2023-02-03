//
//  RootView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 30.01.2023.
//

import SwiftUI

struct RootView: View {
    @StateObject private var audioPlayer = AudioPlayerManger()
    @StateObject private var rootVM = RootViewModel()
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            TabView(selection: $rootVM.currentTab) {
                HomeView()
                    .tag(TabEnum.home)
                ListElementsView()
                    .tag(TabEnum.reels)
                Text("video")
                    .tag(TabEnum.video)
                Text("profile")
                    .tag(TabEnum.profile)
            }
            tabBarView
            
            storyViewBuilder
        }
        .environmentObject(audioPlayer)
        .environmentObject(rootVM)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}


extension RootView{
    private var tabBarView: some View{
        VStack(spacing: 0) {
            if audioPlayer.isPinAudio{
                AudioPinToolBarView(playerManager: audioPlayer)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
                VStack(spacing: 0){
                    Rectangle()
                        .fill(Color.lightGray.opacity(0.3))
                        .frame(height: 1)
                        .padding(.horizontal, -16)
                    HStack{
                        ForEach(TabEnum.allCases, id:\.self){ tab in
                            VStack(spacing: 4){
                                tab.image
                                    .renderingMode(.template)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 18)
                                Text(tab.label)
                                    .font(.caption2)
                            }
                            .foregroundColor(rootVM.currentTab == tab ? .white : .lightGray)
                            .onTapGesture {
                                rootVM.currentTab = tab
                            }
                            .hCenter()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
                .background(Color.primaryBg.ignoresSafeArea())
        }
    }
}


//MARK: - Story view

extension RootView{
    
    @ViewBuilder
    var storyViewBuilder: some View{
        if rootVM.showStoryView{
            StoriesView(stories: $rootVM.selectedStories, close: $rootVM.showStoryView)
                .transition(.move(edge: .bottom))
        }
    }
}



enum TabEnum: Int, CaseIterable{
    case home, reels, create, video, profile
    
    
    var image: Image{
        switch self {
        case .home: return .homeTab
        case .reels: return .reelsTab
        case .create: return .createTab
        case .video: return .videoTab
        case .profile: return .profileTab
        }
    }
    
    var label: String{
        switch self {
        case .home: return "Главная"
        case .reels: return "Ролики"
        case .create: return "Создать"
        case .video: return "Видео"
        case .profile: return "Профиль"
        }
    }
}
