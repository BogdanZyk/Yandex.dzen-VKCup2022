//
//  AudioSimplesSlider.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 29.01.2023.
//

import SwiftUI

struct AudioSimplesSlider: View {
    
    @Binding var value: Double
    let magnitudes: [Float]
    let duration: Double
    let onEditingChanged: (Bool) -> Void
    var isPlay: Bool
    
    @State private var dragGestureTranslation: CGFloat = 0
    @State private var lastDragValue: CGFloat = 0
    
    private func roundToFactor(value: CGFloat, factor: CGFloat) -> CGFloat {
        factor * round(value / factor)
    }
    
    private func checkIndexInRange(_ index: Int) -> Bool{
        guard isPlay else {return false}
        return index < (Int(value) / (Int(duration) / magnitudes.count))
    }
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 3) {
            ForEach(magnitudes.indices, id: \.self) { index in
                let indexInRange: Bool = checkIndexInRange(index + 1)
                Group{
                    Rectangle()
                        .fill(Color.white)
                        .cornerRadius(10)
                        .frame(width: 3, height: normalizeSoundLevel(level: magnitudes[index]))
                        .opacity(indexInRange ? 1 : 0.5)
                        .scaleEffect(indexInRange ? 1.1 : 1)
                        .animation(.default, value: value)
                }
            }
        }
        .gesture(DragGesture(minimumDistance: 0)
            .onChanged({ dragValue in
                
                guard isPlay else {return}
                
                let translation = dragValue.translation
                
                dragGestureTranslation = (translation.width * 0.5 + lastDragValue)
                
                // Set the start marker of the slider
                dragGestureTranslation = dragGestureTranslation >= 0 ? dragGestureTranslation : 0
                
                // Set the end marker of the slider
                dragGestureTranslation = dragGestureTranslation > duration ? duration :  dragGestureTranslation
                
                // Get the increments for the stepepdInterval
                value = roundToFactor(value: dragGestureTranslation, factor: duration / CGFloat(magnitudes.count))
                onEditingChanged(true)
                
            })
                .onEnded({ dragValue in
                    guard isPlay else {return}
                    // Set the start marker of the slider
                    dragGestureTranslation = dragGestureTranslation >= 0 ? dragGestureTranslation : 0
                    
                    // Set the end marker of the slider
                    dragGestureTranslation = dragGestureTranslation > duration ? duration : dragGestureTranslation
                    
                    // Storing last drag value
                    lastDragValue = dragGestureTranslation
                    
                    onEditingChanged(false)
                })
        )
    }
}

struct AudioSimplesSlider_Previews: PreviewProvider {
    @State static var value: Double = 20
    static var previews: some View {
        ZStack{
            Color.primary
       // https://muzati.net/music/0-0-1-20674-20
            //https://muzati.net/music/0-0-1-20146-20
            VStack{
                AudioViewComponent(url: "https://muzati.net/music/0-0-1-20674-20")
                AudioViewComponent(url: "https://muzati.net/music/0-0-1-20146-20")
            }

        }
    }
}





extension AudioSimplesSlider{
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 50) / 2
        
        return CGFloat(level * 1.15)
    }
}
