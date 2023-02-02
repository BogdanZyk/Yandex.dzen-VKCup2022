//
//  QuestionStickerView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 02.02.2023.
//

import SwiftUI

struct QuestionStickerView: View {
    let question: String
    @State var text = ""
    var body: some View {
        VStack{
            Text(question)
                .font(.system(size: 18, weight: .medium))
            TextField("Напишите что нибудь...", text: $text)
                .font(.system(size: 16))
                .padding(.horizontal)
                .frame(height: 50)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .frame(width: getRect().width / 1.5)
        .shadow(color: Color.primaryBg.opacity(0.1), radius: 5, x: 0, y: 0)
    }
}

struct QuestionStickerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.white
            QuestionStickerView(question: "Question?")
                .padding()
        }
        
    }
}
