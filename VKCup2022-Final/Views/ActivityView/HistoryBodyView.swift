//
//  HistoryBodyView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 31.01.2023.
//

import SwiftUI

struct HistoryBodyView: View {
    @Binding var model: History
    var isDisabled: Bool = false
    var body: some View {
        ZStack{
            if let color = model.bgColor{
                Color(hex: color)
            }
            NukeLazyImage(strUrl: model.imageUrl, resizingMode: .aspectFit, loadPriority: .veryHigh)
            ForEach(model.textBoxes) { text in
                Text(text.text)
                    .font(.system(size: CGFloat(text.size), weight: text.isBold ? .bold : .medium))
                    .foregroundColor(Color(hex: text.color))
                    .offset(x: text.offsetX, y: text.offsetY)
                
            }
            if let sticker = Binding<Sticker>($model.sticker) {
                SctickerView(sticker: sticker)
            }
        }
        .disabled(isDisabled)
    }
}

//struct HistoryBodyView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryBodyView(model: <#Binding<History>#>)
//    }
//}
