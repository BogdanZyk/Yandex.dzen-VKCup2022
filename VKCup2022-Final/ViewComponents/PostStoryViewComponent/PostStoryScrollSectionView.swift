//
//  PostStoryScrollSectionView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 30.01.2023.
//

import SwiftUI

struct PostStoryScrollSectionView: View {
    @ObservedObject var rootVM: RootViewModel
    var showStory: Bool = false
    let stories: [Story]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
                ForEach(stories.indices, id: \.self) {index in
                    Button {
                        rootVM.selectedStories = (index, stories)
                        withAnimation(.easeInOut(duration: 0.25)){
                            rootVM.showStoryView.toggle()
                        }
                    } label: {
                        StoryBodyView(model: .constant(stories[index]), isDisabled: true)
                            .frame(width: getRect().width / 3)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .contentShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .buttonStyle(StoryButtonStyle())
                }
            }
            .padding(.horizontal)
            .frame(height: getRect().height / 4)
        }
    }
}

struct PostStoryScrollSectionView_Previews: PreviewProvider {
    static var previews: some View {
        PostStoryScrollSectionView(rootVM: RootViewModel(), stories: Mocks.stories)
    }
}

struct StoryButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
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
