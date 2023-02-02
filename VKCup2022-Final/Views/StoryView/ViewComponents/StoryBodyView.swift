//
//  StoryBodyView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 31.01.2023.
//

import SwiftUI

struct StoryBodyView: View {
    @Binding var model: Story
    var isDisabled: Bool = false
    var body: some View {
        GeometryReader { proxy in
            let textWidth = proxy.size.width - 32
            ZStack{
                if let color = model.image.bgColor{
                    Color(hex: color)
                }
                NukeLazyImage(strUrl: model.image.url, resizeHeight: 600, resizingMode: .aspectFit, loadPriority: .veryHigh)
                    .offset(x: model.image.offsetX, y: model.image.offsetY)
                    .scaleEffect(model.image.scale)
                ForEach(model.textBoxes) { text in
                    Text(text.text)
                        .font(.system(size: CGFloat(text.size), weight: text.isBold ? .bold : .medium))
                        .foregroundColor(Color(hex: text.color))
                        .multilineTextAlignment(.leading)
                        .offset(x: text.offsetX, y: text.offsetY)
                        .frame(width: textWidth)
                        .scaleEffect(textWidth / getRect().width)
                }
                if let sticker = Binding<Sticker>($model.sticker) {
                    StickerView(sticker: sticker)
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .disabled(isDisabled)
        }
        .clipped()
    }
    
}

//struct HistoryBodyView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryBodyView(model: )
//    }
//}
