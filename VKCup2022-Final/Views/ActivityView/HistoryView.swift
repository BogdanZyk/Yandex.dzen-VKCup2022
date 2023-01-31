//
//  HistoryView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 31.01.2023.
//

import SwiftUI

struct HistoryView: View {
    @State var model: History = .init(imageUrl: "https://img2.akspic.ru/crops/1/6/0/7/5/157061/157061-yulijskie_alpy-alpy-oblako-rastenie-ekoregion-1080x1920.jpg", bgColor: "#9D9C28", textBoxes: [.init(text: "Test text\ntext", size: 30, isBold: true, offsetX: -100, offsetY: -100, color: "#FFFFFF"), .init(text: "Hello!🖐", size: 30, isBold: true, offsetX: 50, offsetY: -250, color: "#FFFFFF")], sticker: .init(label: "😄", slideValue: 0, question: "", type: .slider, offsetX: 0, offsetY: 150))
    var body: some View {
        GeometryReader { proxy in
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
            .ignoresSafeArea()
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}




