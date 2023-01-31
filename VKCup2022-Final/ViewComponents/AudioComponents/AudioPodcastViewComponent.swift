//
//  AudioPodcastViewComponent.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 28.01.2023.
//

import SwiftUI

struct AudioPodcastViewComponent: View {
    @ObservedObject var playerManager: AudioPlayerManger
    @State private var isOnAppear: Bool = false
    
    let podcast: Podcast
    
    
    private var soundSamples: [Float]? {
        if let audio = playerManager.currentPodcast?.audio, audio.id == audio.id{
            return audio.decibles
        }else{
            return self.podcast.audio.decibles
        }
    }
    
    private var isPlayCurrentAudio: Bool{
        (playerManager.currentPodcast?.id == podcast.id) && playerManager.isPlaying
    }
    
    private var remainingDuration: String{
        if let audio = playerManager.currentPodcast?.audio, audio.id == audio.id, isPlayCurrentAudio{
            return "\(audio.remainingDuration.minuteSeconds)"
        }else{
            return "\(podcast.audio.remainingDuration.minuteSeconds)"
        }
    }
    
    private var isSetCurrentAudio: Bool{
        playerManager.currentPodcast?.id == podcast.id
    }
    
    var body: some View {
        ZStack{
            
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.lightGray, lineWidth: 1.5)
            
            HStack(alignment: .center, spacing: 0) {
                
                playPauseButton
                
                if let soundSamples{
                    AudioSimplesSlider(value: $playerManager.currentTime, magnitudes: soundSamples.map({$0.magnitude}), duration: podcast.audio.duration, onEditingChanged: onEditingChanged, isPlay: isSetCurrentAudio, isPlayAnimation: isOnAppear)
                        .hCenter()
                        .onTapGesture {
                            playerManager.audioAction(podcast)
                        }
                }
                if isOnAppear{
                    audioDuration
                }
            }
            .foregroundColor(.white)
            .padding(.horizontal)
        }
        .frame(height: 50)
        .onAppear{
            isOnAppear = true
        }
        .onDisappear{
            isOnAppear = false
        }
    }
}


struct AudioViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black
            AudioPodcastViewComponent(playerManager: AudioPlayerManger(), podcast: .init(audio: Mocks.audios[1], channelName: ""))
                .padding()
        }
    }
}

extension AudioPodcastViewComponent{
    
    private var icon: String{
        isPlayCurrentAudio ?  "pause.fill" : "play.fill"
    }
    
    private func barView(value: CGFloat, color: Color) -> some View {
        ZStack {
            Rectangle()
                .fill(color)
                .cornerRadius(10)
                .frame(width: 3, height: value <= 0 ? 3 : value)
        }
    }
    
    

    
    private func onEditingChanged(_ scrubStarted: Bool){
        if scrubStarted{
            playerManager.scrubState = .scrubStarted
        }else{
            playerManager.scrubState = .scrubEnded(playerManager.currentTime)
        }
    }
    
}

extension AudioPodcastViewComponent{
    

    private var playPauseButton: some View{
        Button {
            playerManager.audioAction(podcast)
        } label: {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35, height: 20)
                .foregroundColor(.white)
        }
    }
    
    private var audioDuration: some View{
        Text(remainingDuration)
            .font(.caption)
            .frame(width: 35)
    }
}





