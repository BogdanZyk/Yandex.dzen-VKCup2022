//
//  PostStoryViewComponent.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 30.01.2023.
//

import SwiftUI

struct PostStoryViewComponent: View {
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

struct PostStoryViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        PostStoryViewComponent()
    }
}
