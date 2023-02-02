//
//  ReactionStickerView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 02.02.2023.
//

import SwiftUI

struct ReactionStickerView: View {
    @State private var showParticles: Bool = false
    @State private var show: Bool = false
    let duration: Double = 2
    let label: String
    var body: some View {
        ZStack{
            Text(label)
                .font(.system(size: 50))
                .padding()
                .background(Color.white)
                .clipShape(Circle())
                .contentShape(Circle())
                .shadow(color: Color.primaryBg.opacity(0.1), radius: 5)
                .onTapGesture {
                    guard !showParticles else {return}
                    withAnimation {
                        showParticles = true
                    }
                }
            
            if showParticles{
                ZStack{
                    ForEach(1...10, id: \.self){_ in
                        Text(label)
                            .offset(x: Double.random(in: -200...200), y: Double.random(in: -200...200))
                            .font(.system(size: 60))
                            .modifier(ParticlesModifier(show: $show, speed: Double.random(in: 50...150), duration: duration, particlesMaxCount: 5))
                    }
                }
                .zIndex(1)
            }
                
        }
        .disabled(showParticles)
        .onChange(of: showParticles) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + duration){
                withAnimation {
                    showParticles = false
                }
            }
        }
    }
}

struct ReactionStickerView_Previews: PreviewProvider {
    static var previews: some View {
        ReactionStickerView(label: "😍")
    }
}
