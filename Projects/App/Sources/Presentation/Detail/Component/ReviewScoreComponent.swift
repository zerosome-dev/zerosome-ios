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
    let background: Color
    let heightPadding: CGFloat
    let radius: CGFloat
    let review: String
    let font: ZSFont
    
    var body: some View {
        VStack(spacing:2) {
            Text(review)
                .applyFont(font: font)

            StarComponent(rating: 4, size: 16)
        }
        .padding(.vertical, heightPadding)
        .frame(maxWidth: .infinity)
        .background(background)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
