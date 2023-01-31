//
//  History.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 31.01.2023.
//

import Foundation

struct History: Identifiable{
    var id = UUID()
    var imageUrl: String
    var bgColor: String?
    var textBoxes: [TextBox] = []
    var sticker: Sticker?
}

extension History{
    
    struct TextBox: Identifiable{
        var id = UUID()
        var text = ""
        var size: Int
        var isBold: Bool = false
        var offsetX: Double
        var offsetY: Double
        var color: String
        
    }
    
}


struct Sticker: Identifiable{
    
    var id = UUID()
    
    var label: String?
    var slideValue: Double = 0.0
    var question: String = ""
    var type: StickerType
    
    var offsetX: Double
    var offsetY: Double
    
    
    
    enum StickerType: Int, CaseIterable{
        case slider, button, question
    }
    
}
