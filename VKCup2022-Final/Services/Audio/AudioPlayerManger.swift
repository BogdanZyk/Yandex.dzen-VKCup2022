//
//  AudioPlayerManger.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 28.01.2023.
//

import Foundation
import SwiftUI
import AVKit
import Combine

class AudioPlayerManger: ObservableObject {
    
    private var player = AVPlayer()
    
    @Published var currentTime: Double = .zero
    @Published var currentPodcast: Podcast?
    @Published var isPlaying: Bool = false
    @Published var session: AVAudioSession!
    @Published var currentRate: Float = 1.0
    @Published var isPinAudio: Bool = false
    private var subscriptions = Set<AnyCancellable>()
    
    private var timeObserver: Any?
    
    deinit {
        removeTimeObserver()
    }
    
    
    //MARK: - Public
    
    var scrubState: PlayerScrubState = .reset {
        didSet {
            switch scrubState {
            case .scrubEnded(let seekTime):
                player.seek(to: CMTime(seconds: seekTime, preferredTimescale: 600))
            default : break
            }
        }
    }
    
    func audioAction(_ podcast: Podcast){
        setAudio(podcast)
        if isPlaying {
            pauseAudio()
        } else {
            playAudio()
        }
    }
    
    
    func resetAudio() {
        withAnimation(.easeOut(duration: 0.2)) {
            isPinAudio = false
        }
        pauseAudio()
        currentPodcast = nil
        currentTime = .zero
        currentRate = 1.0
    }
    
    
    
    //MARK: - Private
    
    private func startTimeControlSubscriptions(){
        player.publisher(for: \.timeControlStatus)
            .sink { [weak self] status in
                switch status {
                case .playing:
                    self?.isPlaying = true
                case .paused:
                    self?.isPlaying = false
                case .waitingToPlayAtSpecifiedRate:
                    break
                @unknown default:
                    break
                }
            }
            .store(in: &subscriptions)
    }
    
    
    private func setAudio(_ podcast: Podcast){
        guard currentPodcast?.id != podcast.id, let url = URL(string: podcast.audio.url) else {return}
        AVAudioSessionManager.share.configurePlaybackSession()
        removeTimeObserver()
        currentTime = .zero
        currentPodcast = podcast
        withAnimation(.easeInOut(duration: 0.2)) {
            isPinAudio = true
        }
        player = AVPlayer(url: url)
        startTimeControlSubscriptions()
    }
    
    private func udateRate(){
        player.playImmediately(atRate: currentRate)
    }
    
    private func startTimer() {
        
        let interval = CMTimeMake(value: 1, timescale: 2)
        timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            guard let self = self else { return }
            let time = time.seconds
            
            switch self.scrubState {
            case .reset:
                self.currentTime = time
                self.currentPodcast?.audio.updateRemainingDuration(time)
            case .scrubStarted:
                break
            case .scrubEnded(let seekTime):
                self.scrubState = .reset
                self.currentTime = seekTime
            }
        }
    }
    
    private func playerDidFinishPlaying() {
        withAnimation(.easeInOut(duration: 0.2)) {
            isPinAudio = false
        }
        self.player.pause()
        self.player.seek(to: .zero)
        currentPodcast?.audio.resetRemainingDuration()
        currentPodcast = nil
        currentTime = .zero
    }
    
    public func setBackwardOrForward(isForward: Bool){
        let seconds = isForward ? (currentTime + 15.0) : (currentTime - 15.0)
        if seconds >= currentPodcast?.audio.duration ?? 0 || seconds <= 0{
            scrubState = .scrubEnded(0)
            return
        }
        scrubState = .scrubEnded(seconds)
    }
    
    private func playAudio() {
        if isPlaying{
            pauseAudio()
        } else {
            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                self.playerDidFinishPlaying()
            }
            player.play()
            udateRate()
            startTimer()
        }
    }
    
    private func pauseAudio() {
        player.pause()
    }
    
    private func removeTimeObserver(){
        if let timeObserver = timeObserver {
            player.removeTimeObserver(timeObserver)
        }
    }
    
}


enum PlayerScrubState{
    case reset
    case scrubStarted
    case scrubEnded(Double)
}
