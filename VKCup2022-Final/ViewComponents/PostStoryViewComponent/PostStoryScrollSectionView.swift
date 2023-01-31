//
//  PostStoryScrollSectionView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 30.01.2023.
//

import SwiftUI

struct PostStoryScrollSectionView: View {
    @State private var showLine: Bool = false
    @State private var location: CGPoint = .zero
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
                ForEach(1...5, id: \.self) {_ in
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.lightGray)
                        .frame(width: getRect().width / 3)
                }
            }
            .padding(.horizontal)
            .frame(height: getRect().height / 4)
        }
    }
}

struct PostStoryScrollSectionView_Previews: PreviewProvider {
    static var previews: some View {
        PostStoryScrollSectionView()
    }
}


//
//GeometryReader { proxy in
//    ZStack{
//        Color.primaryBg
//        Text("test")
//            .font(.title.bold())
//            .foregroundColor(.white)
//            .offset(x: location.x, y: location.y)
//            .gesture(DragGesture()
//                .onChanged({ value in
//                    self.location = value.location
//
//                    showLine = (0.0...30.0).contains(abs(value.location.x))
//
//                }).onEnded({ value in
//                    location = (0.0...10.0).contains(abs(value.location.x)) ? CGPoint(x: 0, y: value.location.y) : location
//                }))
//        Text("\(location.x) \(location.y)")
//            .foregroundColor(.white)
//            .padding(.top, 30)
//
//        if showLine{
//            Rectangle()
//                .fill(Color.white.opacity(0.5))
//                .frame(width: 1)
//        }
//    }
//}
