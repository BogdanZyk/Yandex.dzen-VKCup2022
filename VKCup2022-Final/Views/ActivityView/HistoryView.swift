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
        ZStack(alignment: .top){
            Color.primaryBg.ignoresSafeArea()
            ZStack(alignment: .top){
                
                HistoryBodyView(model: $model)
                
                HStack(spacing: 6){
                    ForEach(1...5, id: \.self) {_ in
                        Capsule()
                            .foregroundColor(.white.opacity(0.5))
                            .frame(height: 3)
                    }
                    Button {
                        
                    } label: {
                        Image(systemName: "xmark")
                            .font(.callout.bold())
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.white.opacity(0.3))
                            .clipShape(Circle())
                    }
                    .padding(.leading, 5)
                }
                .padding([.horizontal, .top])
            }
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .frame(height: getRect().height - 150, alignment: .center)
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}




