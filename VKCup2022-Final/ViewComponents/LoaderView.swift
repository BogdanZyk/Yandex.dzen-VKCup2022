//
//  LoaderView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 30.01.2023.
//

import SwiftUI

struct LoaderView: View {
    var size: CGFloat? = 25
    @State private var isLoading: Bool = false
    var body: some View {
        
        Circle()
            .trim(from: 0, to: 0.85)
            .stroke(Color.accentColor, lineWidth: 3)
            .frame(width: size, height: size)
            .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
            .onAppear{
                withAnimation(.linear(duration: 0.5).repeatForever(autoreverses: false)){
                    isLoading = true
                }
            }
            .onDisappear{
                isLoading = false
            }
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            LoaderView()
        }
    }
}
