//
//  StickerSliderView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 31.01.2023.
//

import SwiftUI

struct StickerSliderView: View {
    let label: String
    var question: String?
    @State var offset: Double = 0
    var body: some View {
    
        VStack{
            
            if let question{
                Text(question)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.accentColor)
            }
            
            GeometryReader { proxy in
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                    Group{
                        Capsule()
                            .fill(Color.lightGray.opacity(0.5))
                            .frame(height: 8)
                        
                        Capsule()
                            .fill(LinearGradient(colors: [.orange, .accentColor, .red], startPoint: .leading, endPoint: .trailing))
                            .frame(width: offset + 20, height: 8)
                    }
                    .padding(.horizontal, 5)
                    Text(label)
                        .font(.system(size: 30))
                        .offset(x: offset)
                        .gesture(DragGesture()
                            .onChanged({ value in
                                if value.location.x >= 0 && value.location.x <= proxy.size.width - 30{
                                    offset = value.location.x
                                }
                            }))
                }
            }
            .frame(width: 220, height: 40)
            
        }
        .padding()
        .background(Color.white.cornerRadius(12).shadow(color: .lightGray.opacity(0.5), radius: 5))
    }
}

struct StickerSliderView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            StickerSliderView(label: "😡", question: "Test??")
            StickerSliderView(label: "🤪", question: "Test??\nTesy")
            StickerSliderView(label: "🥰", question: "Test??")
        }
    }
}
