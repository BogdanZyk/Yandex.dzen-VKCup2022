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
    @Published var currentRecordTime: Double = 0
    
    var returnedAudio: Audio?
    
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
                self.currentRecordTime += 0.1
            })
            blinkColor()
            
        } catch {
            print("Failed to Setup the Recording")
        }
    }
    
    
    func stopRecording(){
        print("DEBUG:", "stopRecording")
        audioRecorder.stop()
        resetTimer()
        prepairAudio()
    }
    
    func cancel(){
        print("DEBUG:", "cancel")
        audioRecorder.stop()
        returnedAudio = nil
        recordState = .empty
        resetTimer()
        removeRecordedAudio()
    }
        
   private func prepairAudio(){
        print("DEBUG:", "prepairAudio")
        let url = audioRecorder.url
        
        ///количество симплов в расчете на размер экрана для визуализации звука
        let cimplesCount = Int(UIScreen.main.bounds.width * 0.4) / 4
        
        bufferService.buffer(url: url, samplesCount: cimplesCount) { [weak self] (duration, decibles) in
            guard let self = self else {return}
            
            self.returnedAudio = .init(url: url.absoluteString, duration: duration, decibles: decibles)
            self.recordState = .recordered
            self.removeRecordedAudio()
            
        } onError: {[weak self] _ in
            self?.recordState = .error
        }
    }
    
    
    private func resetTimer(){
        timerCount!.invalidate()
        blinkingCount!.invalidate()
        self.currentRecordTime = 0
    }
    
    private func removeRecordedAudio(){
        
        if FileManager.default.fileExists(atPath: audioRecorder.url.absoluteString){
            do {
                try FileManager.default.removeItem(at: audioRecorder.url)
            } catch {
                print(error)
            }
        }
    }
    
    private func blinkColor() {
        
        blinkingCount = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (value) in
            self.toggleColor.toggle()
        })
        
    }
}



enum AudioRecordEnum: Int{
    case recording, recordered, empty, error
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



