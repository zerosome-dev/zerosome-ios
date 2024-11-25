//
//  ReviewScoreComponent.swift
//  App
//
//  Created by 박서연 on 2024/08/09.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct ReviewScoreComponent: View {
    let background: Color = Color.neutral50
    let heightPadding: CGFloat
    let radius: CGFloat
    let review: Double
    let font: ZSFont
    
    var body: some View {
        VStack(spacing:2) {
            Text(String(format: "%.1f", review))
                .applyFont(font: font)

            RoundedStarComponent(rating: review, size: 16)
        }
        .padding(.vertical, heightPadding)
        .frame(maxWidth: .infinity)
        .background(background)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
