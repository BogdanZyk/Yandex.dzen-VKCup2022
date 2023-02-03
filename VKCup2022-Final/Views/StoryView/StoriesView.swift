//
//  StoriesView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 31.01.2023.
//

import SwiftUI

struct StoriesView: View {
    @State private var isLike: Bool = false
    @StateObject var counTimer: CountTimer
    @Binding var close: Bool
    @State var bgOpacity: Double = 1
    @State private var offsetY: CGSize = .zero
    @GestureState var draggingOffset: CGSize = .zero
    @Binding var stories: [Story]
    
    init(stories: Binding<[Story]>, close: Binding<Bool>){
        self._stories = stories
        self._close = close
        self._counTimer = StateObject(wrappedValue: CountTimer(max: stories.wrappedValue.count, interval: 18))
    }
    
    var indexProgress: Int{
        Int(counTimer.progress)
    }
    
    var body: some View {
        ZStack(alignment: .top){
            Color.primaryBg.ignoresSafeArea()
                .opacity(bgOpacity)
            GeometryReader { proxy in
                VStack(spacing: 16) {
                    ZStack(alignment: .top){
                        
                        StoryBodyView(model: $stories[indexProgress])
                            
                        headerSectionView
                        pageButtonsControls(proxy)
                            .vBottom()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    likeButton
                }
                .offset(y: offsetY.height)
                .frame(height: getRect().height / 1.1, alignment: .center)
                .gesture(DragGesture().updating($draggingOffset, body: { value, outValue, _ in
                    outValue = value.translation
                    onChage(draggingOffset)
                }).onEnded(onEnded))
            }

        }
        .onAppear{
            counTimer.start()
        }
    }
}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView(stories: .constant(Mocks.storiesFood), close: .constant(false))
    }
}


extension StoriesView{
    
    private var headerSectionView: some View{
        HStack(spacing: 6){
            
                
            ForEach(stories.indices, id: \.self) {index in
                let progress = min(max(CGFloat(counTimer.progress) - CGFloat(index), 0.0), 1.0)
                Group{
                    StoryLoadingBar(progress: progress)
                        .frame(height: 3)
                }
            }
            Button {
                closeViewWithAnimation()
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
    
    private var likeButton: some View{
        Button {
            isLike.toggle()
        } label: {
            Image("like")
                .renderingMode(.template)
                .foregroundColor(isLike ? .accentColor : .lightGray)
                .padding()
                .background(Color.white.opacity(0.2))
                .clipShape(Circle())
        }
    }
    
    private func pageButtonsControls(_ proxy: GeometryProxy) -> some View{
        HStack{
            Rectangle()
                .fill(Color.clear)
                .frame(width: proxy.size.width / 5, height: proxy.size.height / 1.3)
                .contentShape(Rectangle())
            
                .onTapGesture {
                    counTimer.advancePage(by: -1)
                }
            
            Spacer()
            Rectangle()
                .fill(Color.clear)
                .frame(width: proxy.size.width / 5, height: proxy.size.height / 1.3)
                .contentShape(Rectangle())
                .onTapGesture {
                    counTimer.advancePage(by: 1)
                }
        }
    }
}



//MARK: - Dragg logic
extension StoriesView{
    private func onChage(_ value: CGSize){
        let haldHeight = getRect().height / 2
        DispatchQueue.main.async {
            offsetY = value.height > 0 ? value : CGSize()
            let progress = offsetY.height / haldHeight
            withAnimation {
                bgOpacity = Double(1 - (progress < 0 ?  -progress : progress))
            }
        }
        
    }
    private func onEnded(_ value: DragGesture.Value){
        let translation = value.translation.height
        DispatchQueue.main.async {
            if translation < 120{
                withAnimation(.default) {
                    bgOpacity = 1
                    offsetY = .zero
                }
                
            }else{
                closeViewWithAnimation()
            }
        }
    }
    
    
    private func closeViewWithAnimation(){
        withAnimation(.easeIn(duration: 0.15)) {
            bgOpacity = 0
            offsetY.height = getRect().height
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
            withAnimation(.linear(duration: 0.1)) {
                close.toggle()
            }
        }
    }
}
