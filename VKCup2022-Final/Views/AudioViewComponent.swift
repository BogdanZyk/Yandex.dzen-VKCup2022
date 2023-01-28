//
//  AudioViewComponent.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 28.01.2023.
//

import SwiftUI

struct AudioViewComponent: View {
    @StateObject var playerManager = AudioPlayerManger()
    
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
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            if let audio = viewModel.audio{
                HStack(alignment: .center, spacing: 10) {
                    
                    Button {
                        playerManager.audioAction(audio)
                    } label: {
                        Image(systemName: icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                    }
                    
                    VStack(alignment: .leading, spacing: 5){
                        HStack(alignment: .center, spacing: 2) {
                            if let soundSamples {
                                ForEach(soundSamples, id: \.self) { model in
                                    barView(value: self.normalizeSoundLevel(level: model.magnitude), color: model.color)
                                }
                            }
                        }
                    }
                    
                    Text(remainingDuration)
                        .font(.caption2)
                }
            }
        }
        .foregroundColor(.white)
    }
}


struct AudioViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black
            AudioViewComponent(url: "https://muzati.net/music/0-0-1-20146-20")
        }
        
    }
}

extension AudioViewComponent{
    
    private var icon: String{
        isPlayCurrentAudio ? "play.fill" : "play.circle.fill"
    }
    
    private func barView(value: CGFloat, color: Color) -> some View {
        ZStack {
            Rectangle()
                .fill(color)
                .cornerRadius(10)
                .frame(width: 2, height: value <= 0 ? 3 : value)
        }
    }
    
    
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 50) / 2
        
        return CGFloat(level * (40/35))
    }
    
}

extension AudioViewComponent{
//    private var activeMicButton: some View{
//        Button {
//            recordManager.startRecording()
//        } label: {
//            Image(systemName: "mic")
//                .imageScale(.medium)
//                .foregroundColor(.black)
//                .padding()
//        }
//    }
//
//    private var InRecordingView: some View{
//        HStack{
//            Circle()
//                .fill(Color.red)
//                .frame(width: 8, height: 8)
//                .opacity(recordManager.toggleColor ? 0 : 1)
//                .animation(.easeInOut(duration: 0.6), value: recordManager.toggleColor)
//            Text(recordManager.remainingDuration.minutesSecondsMilliseconds)
//                .font(.subheadline)
//            Spacer()
//            Label("left to cancel", systemImage: "chevron.left")
//                .font(.subheadline)
//                .padding(.trailing, 30)
//            Spacer()
//
//        }
//        .frame(height: 44)
//    }
}
