//
//  AudioRecorderManager.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 28.01.2023.
//

import Foundation
import Combine
import AVFoundation
import SwiftUI


class AudioRecorderManager : ObservableObject {
    
    var audioRecorder : AVAudioRecorder!
    
    let bufferService: AudioBufferService = AudioBufferService.shared
    
    @Published var recordState: AudioRecordEnum = .empty
    @Published var isLoading: Bool = false
    @Published var uploadURL: URL?
    @Published var toggleColor : Bool = false
    @Published var timerCount : Timer?
    @Published var blinkingCount : Timer?
    @Published var remainingDuration: Double = 0
    @Published var returnedAudio: Audio?
   
    
    init(){
        AVAudioSessionManager.share.configureRecordAudioSessionCategory()
    }
   
 
    func startRecording(){
        print("DEBUG:", "startRecording")
    
        let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let audioCachURL = path.appendingPathComponent("Voice-\(UUID().uuidString).m4a")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            audioRecorder = try AVAudioRecorder(url: audioCachURL, settings: settings)
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            recordState = .recording
            timerCount = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (value) in
                self.remainingDuration += 0.1
            })
            blinkColor()
            
        } catch {
            print("Failed to Setup the Recording")
        }
    }
    
    
    func stopRecording(){
        print("DEBUG:", "stopRecording")
        audioRecorder.stop()
        timerCount!.invalidate()
        blinkingCount!.invalidate()
        prepairAudio()
    }
    
    func cancel(){
        print("DEBUG:", "cancel")
        audioRecorder.stop()
        timerCount!.invalidate()
        blinkingCount!.invalidate()
        returnedAudio = nil
        recordState = .empty
        remainingDuration = 0
    }
    
    func prepairAudio(){
        print("DEBUG:", "prepairAudio")
        let url = audioRecorder.url
        print(remainingDuration)
//        bufferService.buffer(url: url, samplesCount: 30) {[weak self] (duration, decibles) in
//            guard let self = self else {return}
//            self.returnedAudio  = .init(url: url, duration: duration, decibles: decibles)
//                self.recordState = .recordered
//                self.remainingDuration = 0
//        }
    }

    func uploadAudio(completion: @escaping (Audio) -> Void){
//        print("DEBUG:", "uploadAudio", returnedAudio?.duration)
//         guard let returnedAudio = returnedAudio else {return}
//         let url = returnedAudio.url
//         bufferService.buffer(url: url, samplesCount: 30) {[weak self] decibles in
//             guard let self = self else {return}
//             let updloadedAudio: Audio = .init(url: <#T##URL#>, duration: <#T##Double#>, decibles: <#T##[Float]#>)
//             completion(updloadedAudio)
//             self.recordState = .empty
//         }
    }
    
    
    private func blinkColor() {
        
        blinkingCount = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (value) in
            self.toggleColor.toggle()
        })
        
    }
}



enum AudioRecordEnum: Int{
    case recording, recordered, empty
}


extension TimeInterval {
    var minutesSecondsMilliseconds: String {
        String(format: "%02.0f:%02.0f:%02.0f",
               (self / 60).truncatingRemainder(dividingBy: 60),
               truncatingRemainder(dividingBy: 60),
               (self * 100).truncatingRemainder(dividingBy: 100).rounded(.down))
    }
    var minuteSeconds: String{
        String(format: "%02.0f:%02.0f",
               (self / 60).truncatingRemainder(dividingBy: 60),
               truncatingRemainder(dividingBy: 60))
    }
}


