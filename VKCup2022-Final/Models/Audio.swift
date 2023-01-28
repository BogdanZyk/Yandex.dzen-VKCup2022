//
//  Audio.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 28.01.2023.
//

import SwiftUI

struct Audio: Identifiable{
    
    var id = UUID()
    var url: URL
    var duration: Double
    var audioSimples: [AudioSimple]
    var remainingDuration: Double
    
    init(url: URL, duration: Double, decibles: [Float]) {
        self.url = url
        self.duration = duration
        self.remainingDuration = duration
        self.audioSimples = decibles.map({.init(magnitude: $0)})
    }
    
}

extension Audio{
    
    struct AudioSimple: Hashable {
        var magnitude: Float
        var color: Color = .white.opacity(0.5)
    }
}


extension Audio{
    
    mutating func setDefaultColor(){
        self.audioSimples = self.audioSimples.map { tmp -> AudioSimple in
            var cur = tmp
            cur.color = Color.white.opacity(0.5)
            return cur
        }
    }
    mutating func updateRemainingDuration(_ currentTime: Double){
        let dif = duration - currentTime
        if dif > 0{
            remainingDuration = dif
        }
    }
    
    mutating func resetRemainingDuration(){
        remainingDuration = duration
    }
}
