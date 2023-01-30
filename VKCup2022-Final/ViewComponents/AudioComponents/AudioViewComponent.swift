//
//  AudioViewComponent.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 28.01.2023.
//

import SwiftUI

struct AudioViewComponent: View {
    
    @EnvironmentObject var playerManager: AudioPlayerManger
    
    let audio: Audio
    
    
    private var soundSamples: [Float]? {
        if let audio = playerManager.currentAudio, audio.id == audio.id{
            return audio.decibles
        }else{
            return self.audio.decibles
        }
    }
    
    private var isPlayCurrentAudio: Bool{
        (playerManager.currentAudio?.id == audio.id) && playerManager.isPlaying
    }
    
    private var remainingDuration: String{
        if let audio = playerManager.currentAudio, audio.id == audio.id{
            return "\(audio.remainingDuration.minuteSeconds)"
        }else{
            return "\(audio.remainingDuration.minuteSeconds)"
        }
    }
    
    private var isSetCurrentAudio: Bool{
        playerManager.currentAudio?.id == audio.id
    }
    
    var body: some View {
        ZStack{
            
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.lightGray, lineWidth: 1.5)
            
            HStack(alignment: .center, spacing: 0) {
                
                playPauseButton(audio)
                
                if let soundSamples{
                    AudioSimplesSlider(value: $playerManager.currentTime, magnitudes: soundSamples.map({$0.magnitude}), duration: audio.duration, onEditingChanged: onEditingChanged, isPlay: isSetCurrentAudio)
                        .hCenter()
                        .onTapGesture {
                            playerManager.audioAction(audio)
                        }
                }
                
                audioDuration
            }
            .foregroundColor(.white)
            .padding(.horizontal)
        }
        .frame(height: 50)
    }
}


struct AudioViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black
            AudioViewComponent(audio: Mocks.audios[1])
                .padding()
        }
        .environmentObject(AudioPlayerManger())
    }
}

extension AudioViewComponent{
    
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
        //guard isPlayCurrentAudio else {return}
        if scrubStarted{
            playerManager.scrubState = .scrubStarted
        }else{
            playerManager.scrubState = .scrubEnded(playerManager.currentTime)
        }
    }
    
}

extension AudioViewComponent{
    

    private func playPauseButton(_ audio: Audio) -> some View{
        Button {
            playerManager.audioAction(audio)
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





