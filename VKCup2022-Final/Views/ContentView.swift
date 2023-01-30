//
//  ContentView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 28.01.2023.
//

import SwiftUI


struct ContentView: View {
    @StateObject var audioPlayer = AudioPlayerManger()
    var body: some View {
        ZStack(alignment: .top){
            Color.primaryBg.ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10){
                    AudioViewComponent(audio: Mocks.audios[1])
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
    }
}
