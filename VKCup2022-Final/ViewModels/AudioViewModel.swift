//
//  AudioViewModel.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 28.01.2023.
//

import Foundation

class AudioViewModel: ObservableObject{
    
    let bufferService: AudioBufferService = AudioBufferService.shared
    
    @Published var audio: Audio?
    @Published var state: AudioState = .loading
    @Published var errorMessge: String = ""
    
    init(_ url: String){
        crateAudioModel(for: url)
    }
    
    
    func crateAudioModel(for url: String){
        guard let url = URL(string: url) else {return}
        state = .loading
        bufferService.buffer(url: url, samplesCount: 30) {[weak self] (duration, decibles) in
            guard let self = self else {return}
            self.audio = .init(url: url, duration: duration.rounded(.up), decibles: decibles)
            self.state = .load
        }onError: { [weak self] error in
            self?.state = .error("Ошибка при загрузке аудио")
        }
    }
    
    enum AudioState{
        case load, error(String), loading
    }
}


