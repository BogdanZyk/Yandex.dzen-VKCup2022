//
//  AudioViewComponent.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 28.01.2023.
//

import SwiftUI

struct AudioViewComponent: View {
    
    @EnvironmentObject var playerManager: AudioPlayerManger
    
    @StateObject private var viewModel: AudioViewModel
    
    init(url: String){
        self._viewModel = StateObject(wrappedValue: AudioViewModel(url))
    }
    
    
    private var soundSamples: [Audio.AudioSimple]? {
        if let audio = playerManager.currentAudio, audio.id == viewModel.audio?.id{
            return audio.audioSimples
        }else{
           return viewModel.audio?.audioSimples
        }
    }
    
    private var isPlayCurrentAudio: Bool{
        (playerManager.currentAudio?.id == viewModel.audio?.id) && playerManager.isPlaying
    }
    
    private var remainingDuration: String{
        if let audio = playerManager.currentAudio, audio.id == viewModel.audio?.id{
            return "\(audio.remainingDuration.minuteSeconds)"
        }else{
            return "\(viewModel.audio?.remainingDuration.minuteSeconds ?? "")"
        }
    }
    
    private var isSetCurrentAudio: Bool{
        playerManager.currentAudio?.id == viewModel.audio?.id
    }
    
    var body: some View {
        ZStack{
            if viewModel.state == .loading{
                LoaderView()
            }else{
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.lightGray, lineWidth: 1.5)
                VStack(alignment: .center) {
                    if let audio = viewModel.audio, viewModel.state == .load{
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
                    }else{
                        Text("Ошибка при загрузке аудио")
                            .font(.subheadline)
                    }
                }
                .foregroundColor(.white)
                .padding(.horizontal)
            }
        }
        .frame(height: 50)
    }
}


struct AudioViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black
            AudioViewComponent(url: "https://muzati.net/music/0-0-1-20146-20")
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





