//
//  ParticlesWallView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 02.02.2023.
//

import SwiftUI

struct ParticlesWallView: View {
    @State var show: Bool = true
    var body: some View {
        ZStack{
            if show{
                ZStack{
                    ForEach(1...10, id: \.self){_ in
                        Text("😍")
                            .offset(x: Double.random(in: -200...200), y: Double.random(in: -100...200))
                            .font(.system(size: 60))
                            .modifier(ParticlesModifier(show: $show, speed: Double.random(in: 50...150), duration: 3, particlesMaxCount: 5))
                    }
                }
            }
            Button {
                show = true
            } label: {
                Text("Show")
            }

        }
        .allFrame()
    }
}

struct ParticlesWallView_Previews: PreviewProvider {
    static var previews: some View {
        ParticlesWallView()
    }
}
