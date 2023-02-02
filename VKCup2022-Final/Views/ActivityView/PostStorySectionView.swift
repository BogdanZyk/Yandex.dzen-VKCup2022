//
//  PostStorySectionView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 30.01.2023.
//

import SwiftUI

struct PostStorySectionView: View {
    @ObservedObject var rootVM: RootViewModel
    var showStory: Bool = false
    let preview: Post.StoryPreview
    let stories: [Story]
    var body: some View {
        Button {
            rootVM.selectedStories = stories
            withAnimation(.easeInOut(duration: 0.25)){
                rootVM.showStoryView.toggle()
            }
        } label: {
            HStack(alignment: .center, spacing: 16){
                imageSection
                titleSection
            }
            .padding()
            .hLeading()
            .background(Color.secondaryGray2)
            .cornerRadius(16)
        }
        .buttonStyle(StoryButtonStyle())
    }
}

struct PostStorySectionView_Previews: PreviewProvider {
    static var previews: some View {
        PostStorySectionView(rootVM: RootViewModel(), preview: .init(title: "Простые рецепты для здорового питания", image: "https://res.cloudinary.com/grand-canyon-university/image/fetch/w_750,h_564,c_fill,g_faces,q_auto/https://www.gcu.edu/sites/default/files/2020-09/programming.jpg"), stories: Mocks.stories)
            .padding()
    }
}

extension PostStorySectionView{
    private var imageSection: some View{
    
        ZStack(alignment: .topLeading) {
            ZStack{
                NukeLazyImage(strUrl: preview.image)
                    .frame(width: 82, height: 82)
                    .cornerRadius(24)
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.accentColor, lineWidth: 1.5)
            }
            .frame(width: 90, height: 90)
            Image("story-play")
                .offset(x: -10, y: -10)
        }
    }
    
    
    private var titleSection: some View{
        VStack(alignment: .leading, spacing: 0){
            Text(preview.title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .lineSpacing(2.5)
                .lineLimit(2)
            Spacer()
            HStack{
                Label("123", image: "eye")
                Label("123", image: "smile")
            }
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.lightGray)
        }
        .frame(height: 80)
    }
}


struct StoryButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}


