//
//  AudioPinToolBarView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 30.01.2023.
//

import SwiftUI

struct AudioPinToolBarView: View {
    @ObservedObject var playerManager: AudioPlayerManger
    
    var body: some View {
        VStack(spacing: 0) {
            if let audio = playerManager.currentPodcast?.audio{
                let time = playerManager.currentTime >= audio.duration ? audio.duration : playerManager.currentTime
                ProgressView(value: time, total: audio.duration)
                    .progressViewStyle(LinerProgressStyle())
                    .frame(height: 4)
            }
            HStack{
                playButton
                Spacer()
                
                title
                
                Spacer()
                closeButton
            }
            .foregroundColor(.white)
            .padding(.horizontal)
            .padding(.top, 5)
            Spacer()
        }
        .frame(height: 50)
        .background(Color.primaryBg)
    }
}

struct AudioPinToolBarView_Previews: PreviewProvider {
    static var previews: some View {
        AudioPinToolBarView(playerManager: AudioPlayerManger())
    }
}


extension AudioPinToolBarView {
    
    @ViewBuilder
    private var playButton: some View{
        if playerManager.isLoading{
           ProgressView()
        }else{
            Button {
                if let audio = playerManager.currentPodcast{
                    playerManager.audioAction(audio)
                }
            } label: {
                Image(systemName: playerManager.isPlaying ? "pause.fill" : "play.fill")
                    .imageScale(.medium)
            }
        }
    }
    
    private var closeButton: some View{
        Button {
            playerManager.resetAudio()
        } label: {
            Image(systemName: "xmark")
                .imageScale(.medium)
        }
    }
    
    private var title: some View{
        HStack(alignment: .lastTextBaseline, spacing: 5){
            Button {
                playerManager.setBackwardOrForward(isForward: false)
            } label: {
                backwardLabel(isForward: false)
            }
            
            VStack(alignment: .center, spacing: 1){
                Text("Подкаст")
                    .lineLimit(1)
                    .font(.caption2)
                    .foregroundColor(.lightGray)
                Text(playerManager.currentPodcast?.channelName ?? "--")
                    .lineLimit(1)
                    .font(.system(size: 14, weight: .medium))
            }
            .frame(maxWidth: 80)
            
            Button {
                playerManager.setBackwardOrForward(isForward: true)
            } label: {
                backwardLabel(isForward: true)
            }
        }
        .disabled(playerManager.isLoading)
    }
    
    private func backwardLabel(isForward: Bool) -> some View{
        Image(isForward ? "forward" : "backward")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 28)
    }
}





struct LinerProgressStyle: ProgressViewStyle {
    
    var line1Color: Color = .clear
    var line2Color: Color = .accentColor
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        
        return  ZStack(alignment: .topLeading) {
            GeometryReader { geo in
                
                ZStack(alignment: .leading){
                    Rectangle()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .foregroundColor(line1Color)
                    
                    Rectangle()
                        .frame(maxWidth: geo.size.width * CGFloat(fractionCompleted))
                        .foregroundColor(line2Color)
                        .animation(.linear, value: fractionCompleted)
                }
            }
        }
    }
}
