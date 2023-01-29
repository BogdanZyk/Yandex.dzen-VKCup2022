//
//  AudioBufferService.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 28.01.2023.
//

import Foundation
import AVFoundation

class AudioBufferService {
    static let shared: AudioBufferService = AudioBufferService()
    private init() { }
}

extension AudioBufferService {
    
    func buffer(url: URL, samplesCount: Int, completion: @escaping (_ duration: Double, _ decibles: [Float]) -> Void, onError: @escaping (Error) -> Void) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                var cur_url = url
                if url.absoluteString.hasPrefix("https://") {
                    let data = try Data(contentsOf: url)
                    
                    let directory = FileManager.default.temporaryDirectory
                    let fileName = "chunk.m4a"
                    cur_url = directory.appendingPathComponent(fileName)
                    
                    try data.write(to: cur_url)
                }
                
                let file = try AVAudioFile(forReading: cur_url)
                let audioNodeFileLength = AVAudioFrameCount(file.length)
                if let format = AVAudioFormat(commonFormat: .pcmFormatFloat32,
                                              sampleRate: file.fileFormat.sampleRate,
                                              channels: file.fileFormat.channelCount, interleaved: false),
                   let buf = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: audioNodeFileLength) {
                
                    try file.read(into: buf)
                    guard let floatChannelData = buf.floatChannelData else { return }
                    let frameLength = Int(buf.frameLength)
                    
                    let samples = Array(UnsafeBufferPointer(start:floatChannelData[0], count:frameLength))
                    //        let samples2 = Array(UnsafeBufferPointer(start:floatChannelData[1], count:frameLength))
                    
                    var decibles = [Float]()
                    
                    let chunked = samples.chunked(into: samples.count / samplesCount)
                    for row in chunked {
                        var accumulator: Float = 0
                        let newRow = row.map{ $0 * $0 }
                        accumulator = newRow.reduce(0, +)
                        let power: Float = accumulator / Float(row.count)
                        let decibl = 10 * log10f(power)
                        
                        decibles.append(decibl)
                        
                    }
                    
                    DispatchQueue.main.async {
                        completion(file.duration, decibles)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    onError(error)
                }
            }
        }
    }
}



extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}


extension AVAudioFile{

    var duration: TimeInterval{
        let sampleRateSong = Double(processingFormat.sampleRate)
        let lengthSongSeconds = Double(length) / sampleRateSong
        return lengthSongSeconds
    }

}
