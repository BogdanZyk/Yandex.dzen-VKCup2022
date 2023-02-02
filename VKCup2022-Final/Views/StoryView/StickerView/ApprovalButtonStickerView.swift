//
//  ApprovalButtonStickerView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 02.02.2023.
//

import SwiftUI

struct ApprovalButtonStickerView: View {
    @Binding var isVoted: Bool
    var value: Double
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0){
                button(isApproval: true, persent: 1 - value, proxy: proxy)
                
                Divider()
                
                button(isApproval: false, persent: value, proxy: proxy)
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .cornerRadius(12)
            .shadow(color: Color.primaryBg.opacity(0.1), radius: 5)
        }
        .frame(width: 200, height: 65)
    }
}

struct ApprovalButtonStickerView_Previews: PreviewProvider {
    static var previews: some View {
        ApprovalButtonStickerView(isVoted: .constant(false), value: 0.55)
    }
}

extension ApprovalButtonStickerView{
    private func button(isApproval: Bool, persent: Double, proxy: GeometryProxy) -> some View{
        Button {
            isVoted.toggle()
        } label: {
            VStack(spacing: 6){
                Text(isApproval ? "Да" : "Нет")
                if isVoted{
                    Text("\(String(format: "%0.0f", (persent * 100)))%")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                }
                
            }
            .foregroundColor(isApproval ? .green : .red)
            .frame(width: proxy.size.width / 2, height: proxy.size.height)
            .background(Color.white)
            .font(.system(size: 22, weight: .medium))
        }
        .disabled(isVoted)
    }
}
