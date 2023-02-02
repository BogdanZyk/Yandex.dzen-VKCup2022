//
//  StickerView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 31.01.2023.
//

import SwiftUI

struct StickerView: View {
    @Binding var sticker: Sticker
    var body: some View {
        Group{
            switch sticker.type{
            case .slider:
                emojiSlider
            case .reaction:
                reactionButton
            case .button:
                approvalButton
            }
        }
        .offset(x: sticker.offsetX, y: sticker.offsetY)
    }
}

struct StickerView_Previews: PreviewProvider {
    static var previews: some View {
        StickerView(sticker: .constant(.init(label: "😍", slideValue: 0, type: .slider, offsetX: 0, offsetY: 0)))
    }
}


//MARK: - slider

extension StickerView{
    private var emojiSlider: some View{
        StickerSliderView(label: sticker.label ?? "😀", value: $sticker.slideValue)
    }
}

//MARK: - Question

extension StickerView{
    private var approvalButton: some View{
        ApprovalButtonStickerView(isVoted: $sticker.isVoted, value: sticker.votedCount, labels: sticker.buttonLabels)
    }
}


//MARK: - Reaction

extension StickerView{
    private var reactionButton: some View{
        ReactionStickerView(label: sticker.label ?? "😀")
    }
}
