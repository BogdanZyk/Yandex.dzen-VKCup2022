//
//  TestAnnimation.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 01.02.2023.
//

import SwiftUI

struct TestAnnimation: View {
    @State var show: Bool = false
    @State private var currentIndex: Int = 0
    @Namespace var namespace
    var body: some View {
        ZStack{
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack{
                    ForEach(1...10, id: \.self) { index in
                        if currentIndex == index && show{
                            Color.clear
                                .frame(width: 200, height: 200)
                        }else{
                            cellView(index)
                                .frame(width: 200, height: 200)
                                
                                .onTapGesture {
                                    withAnimation {
                                        currentIndex = index
                                        show.toggle()
                                    }
                                }
                           
                        }
                        
                    }
                }
                .padding(.horizontal)
                .frame(height: 200)
            }
            
            if show{
                cellView(currentIndex)
                    .onTapGesture {
                        withAnimation {
                            show.toggle()
                        }
                    }
            }
        }
    }
}

struct TestAnnimation_Previews: PreviewProvider {
    static var previews: some View {
        TestAnnimation()
    }
}


extension TestAnnimation{
    private func cellView(_ index: Int) -> some View{
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.lightGray)
            .matchedGeometryEffect(id: index, in: namespace)
    }
}
