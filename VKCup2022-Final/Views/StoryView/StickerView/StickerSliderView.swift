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

    @Binding var value: Double
    @State var dragGestureTranslation: CGFloat = 0
    @State var lastDragValue: CGFloat = 0
    @State var showParticles: Bool = false
    @State var isSlide: Bool = false
    var sliderWidth: CGFloat = 30
    var sliderPadding: CGFloat = -5
        
    private func interval(width: CGFloat, increment: Int) -> CGFloat {
        width * CGFloat(increment)
    }
    
    private  func roundToFactor(value: CGFloat, factor: CGFloat) -> CGFloat {
        factor * round(value / factor)
    }
    
    var body: some View {
    
        ZStack(alignment: .top) {

            emojiValueLabel
                
        
            VStack{
                if let question{
                    Text(question)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.accentColor)
                }
                
                GeometryReader { geometry in
                    // Slider Bar
                    
                    let slidebarSize = (geometry.size.width - sliderWidth - sliderPadding * 2)
                    
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color.lightGray.opacity(0.5))
                            Capsule()
                                .fill(LinearGradient(colors: [.orange, .accentColor, .red], startPoint: .leading, endPoint: .trailing))
                                .frame(width: CGFloat(value) * slidebarSize)
                        }
                        .frame(width: geometry.size.width, height: 8)
                        
                        // Draggable Slider
                        ZStack{
                            Text(label)
                            
                        }
                        .frame(width: sliderWidth, height: 30)
                        .padding(.horizontal, sliderPadding)
                        .font(.system(size: 30))
                        .offset(x: CGFloat(value) * slidebarSize)
                        
                        .gesture(DragGesture(minimumDistance: 0)
                            .onChanged({ dragValue in
                                isSlide = true
                                let translation = dragValue.translation
                                
                                
                                dragGestureTranslation = CGFloat(translation.width) + lastDragValue
                                
                                // Set the start marker of the slider
                                dragGestureTranslation = dragGestureTranslation >= 0 ? dragGestureTranslation : 0
                                
                                // Set the end marker of the slider
                                dragGestureTranslation = dragGestureTranslation > slidebarSize ? slidebarSize :  dragGestureTranslation
                                
                                
                                
                                // Set the slider value (Fluid)
                                self.value = (Double(min(max(0, dragGestureTranslation), dragGestureTranslation)).rounded() / slidebarSize)
                                
                                
                            })
                                .onEnded({ dragValue in
                                    
                                    isSlide = false
                                    // Set the start marker of the slider
                                    dragGestureTranslation = dragGestureTranslation >= 0 ? dragGestureTranslation : 0
                                    
                                    // Set the end marker of the slider
                                    dragGestureTranslation = dragGestureTranslation > slidebarSize ? slidebarSize : dragGestureTranslation
                                    
                                    // Storing last drag value
                                    lastDragValue = dragGestureTranslation
                                    
                                    showParticles = value >= 0.5
                                })
                        )
                    }
                }
                .frame(width: 220, height: 30)
            }
            .padding()
        .background(Color.white.cornerRadius(12).shadow(color: .lightGray.opacity(0.5), radius: 5))
        }
    }
}

struct StickerSliderView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            StickerSliderView(label: "😡", question: "Test??", value: .constant(0.9))
            StickerSliderView(label: "🤪", value: .constant(0))
//            StickerSliderView(label: "🥰", question: "Test??", offset: .constant(0))
        }
    }
}



extension StickerSliderView{
    
    @ViewBuilder
    private var emojiValueLabel: some View{
        
        if value > 0{
            ZStack{
                if isSlide{
                    Text(label)
                        .scaleEffect(value * 2.5)
                }
                
                if showParticles{
                    Text(label)
                        .modifier(ParticlesModifier(show: $showParticles, speed: Double.random(in: 60...80), duration: 1.5, particlesMaxCount: 15))
                        .font(.system(size: 30))
                }
            }
            .animation(.easeInOut, value: isSlide)
            .offset(x: CGFloat(value) * (100 - sliderWidth - sliderPadding * 2),  y: -50)
            .zIndex(1)
        }
    }
    
}
