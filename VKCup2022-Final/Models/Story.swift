//
//  Story.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 31.01.2023.
//

import Foundation



/// Примерная модель истории
/// Автор  сможет прикреплять к посту небольшие истории
 /// Состоят:
 /// Фоновой картинки и цвета фона, изменяемое положение и маштаб
 /// Тест изменяемый цвет, положение и маштаб
 /// Три вида интерактивных стикеров:
 /// Стикер слайдер
 /// Стикер кнопка
 /// Стикер ответа на вопрос
 /// Фото превью
 /// Заголовок превью


struct Story: Identifiable{
    var id = UUID()
    let image: BackgroundImage
    var textBoxes: [TextBox] = []
    var sticker: Sticker?
}

extension Story{
    
    struct TextBox: Identifiable{
        var id = UUID()
        var text = ""
        var size: Int
        var isBold: Bool = false
        var offsetX: Double
        var offsetY: Double
        var color: String
        
    }
    
    struct BackgroundImage{
        var url: String
        var offsetX: Double
        var offsetY: Double
        var scale: Double = 1
        var bgColor: String?
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
