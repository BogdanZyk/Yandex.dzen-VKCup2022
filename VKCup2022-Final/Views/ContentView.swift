//
//  ContentView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 28.01.2023.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var audioPlayer: AudioPlayerManger
    var body: some View {
        ZStack(alignment: .top){
            Color.primaryBg.ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 30){
                    ForEach(Mocks.audios){audio in
                        AudioViewComponent(playerManager: audioPlayer, audio: audio)
                    }
                }
                .padding()
            }
        }
        .environmentObject(audioPlayer)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AudioPlayerManger())
    }
}
