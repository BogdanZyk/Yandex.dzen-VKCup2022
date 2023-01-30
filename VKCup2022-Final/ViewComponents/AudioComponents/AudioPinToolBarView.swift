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
        ZStack{
            Color.primaryBg
            VStack(spacing: 0) {
                if let audio = playerManager.currentAudio{
                    ProgressView(value: playerManager.currentTime, total: audio.duration)
                        .progressViewStyle(LinerProgressStyle())
                        .frame(height: 4)
                }
                Spacer()
                HStack{
                    playButton
                    Spacer()
                    
                    title
                    
                    Spacer()
                    closeButton
                }
                .foregroundColor(.white)
                .padding(.horizontal)
                Spacer()
            }
        }
        .frame(height: 50)
    }
}

struct AudioPinToolBarView_Previews: PreviewProvider {
    static var previews: some View {
        AudioPinToolBarView(playerManager: AudioPlayerManger())
    }
}


extension AudioPinToolBarView {
    private var playButton: some View{
        Button {
            if let audio = playerManager.currentAudio{
                playerManager.audioAction(audio)
            }
        } label: {
            Image(systemName: playerManager.isPlaying ? "pause.fill" : "play.fill")
                .imageScale(.medium)
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
        HStack(spacing: 16){
            Button {
                playerManager.setBackwardOrForward(isForward: false)
            } label: {
                backwardLabel(isForward: false)
            }
            
            VStack(alignment: .center){
                Text("RozetKed")
                    .lineLimit(1)
                    .font(.subheadline.weight(.medium))
                Text("Squid Game Podcast")
                    .lineLimit(1)
                    .font(.caption2)
                    .foregroundColor(.lightGray)
            }
            
            Button {
                playerManager.setBackwardOrForward(isForward: true)
            } label: {
                backwardLabel(isForward: true)
            }
        }
        
    }
    
    private func backwardLabel(isForward: Bool) -> some View{
        Image(isForward ? "forward" : "backward")
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
