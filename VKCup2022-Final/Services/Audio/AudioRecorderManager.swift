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
    
    var returnedAudioUrlStr: String?
    
    init(){
        AVAudioSessionManager.share.configureRecordAudioSessionCategory()
    }
   
 
    func startRecording(){
        print("DEBUG:", "startRecording")
    
        let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let audioCachURL = path.appendingPathComponent("Voice-\(UUID().uuidString).m4a")
        self.returnedAudioUrlStr = audioCachURL.absoluteString
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
    }
    
    func cancel(){
        print("DEBUG:", "cancel")
        audioRecorder.stop()
        timerCount!.invalidate()
        blinkingCount!.invalidate()
        returnedAudioUrlStr = nil
        recordState = .empty
        remainingDuration = 0
    }

    func uploadAudio(completion: @escaping (String) -> Void){
        print("DEBUG:", "uploadAudio")
        if let urlStr = returnedAudioUrlStr{
            completion(urlStr)
        }
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
    
    
    var minuteSeconds: String {
        guard self > 0 && self < Double.infinity else {
            return "unknown"
        }
        let time = NSInteger(self)
        
        let seconds = time % 60
        let minutes = (time / 60) % 60
        
        return String(format: "%0.2d:%0.2d", minutes, seconds)
        
    }
}



