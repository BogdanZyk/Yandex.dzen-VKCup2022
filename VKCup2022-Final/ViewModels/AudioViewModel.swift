//
//  AudioViewModel.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 28.01.2023.
//

import SwiftUI

class AudioViewModel: ObservableObject{
    
    let bufferService: AudioBufferService = AudioBufferService.shared
    
    @Published var audio: Audio?
    @Published var state: AudioState = .loading

    
    init(_ url: String){
        crateAudioModel(for: url)
    }
    
    
    func crateAudioModel(for url: String){
        guard let url = URL(string: url) else {return}
        state = .loading
        bufferService.buffer(url: url, samplesCount: Int(UIScreen.main.bounds.width * 0.4) / 4) {[weak self] (duration, decibles) in
            guard let self = self else {return}
            self.audio = .init(url: url, duration: duration.rounded(.up), decibles: decibles)
            withAnimation {
                self.state = .load
            }
        }onError: { [weak self] _ in
            withAnimation {
                self?.state = .error
            }
        }
    }
    
    enum AudioState: Int{
        case load, error, loading
    }
}


