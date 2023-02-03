//
//  HomeView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 30.01.2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var rootVM: RootViewModel
    @EnvironmentObject var audioPlayer: AudioPlayerManger
    var body: some View {
        VStack(spacing: 0) {
            navView
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 10) {
                    ForEach(rootVM.posts){post in
                        PostView(post: post)
                    }
                }
                .padding(.top)
                .padding(.bottom, 100)
            }
        }
        .background(Color.primaryBg.ignoresSafeArea())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(RootViewModel())
    }
}

extension HomeView{
    private var navView: some View{
        VStack(spacing: 0) {
            HStack{
                Image(systemName: "sparkle")
                Text("Дзен")
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom)
            Divider().background(Color.lightGray)
        }
        .font(.title2.bold())
        .foregroundColor(.white)
        .background(Color.secondaryGray.ignoresSafeArea())
    }
}
