//
//  Audio.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 28.01.2023.
//

import SwiftUI

struct Audio: Identifiable, Equatable{
    
    var id = UUID()
    var url: String
    var duration: Double
    var decibles: [Float]
    var remainingDuration: Double
    
    init(url: String, duration: Double, decibles: [Float]) {
        self.url = url
        self.duration = duration
        self.remainingDuration = duration
        self.decibles = decibles
    }
    
}




extension Audio{
   
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
