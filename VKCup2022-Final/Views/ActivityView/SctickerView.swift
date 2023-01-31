//
//  SctickerView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 31.01.2023.
//

import SwiftUI

struct SctickerView: View {
    @Binding var sticker: Sticker
    var body: some View {
        Group{
            switch sticker.type{
            case .slider:
                emojiSlider
            case .button:
                VStack{}
            case .question:
                VStack{}
            }
        }
        .offset(x: sticker.offsetX, y: sticker.offsetY)
    }
}

struct SctickerView_Previews: PreviewProvider {
    static var previews: some View {
        SctickerView(sticker: .constant(.init(label: "", slideValue: 0, question: "", type: .button, offsetX: 0, offsetY: 0)))
    }
}


//MARK: - slider

extension SctickerView{
    private var emojiSlider: some View{
        StickerSliderView(label: sticker.label ?? "😀")
    }
}
