//
//  BannerCircleComponent.swift
//  App
//
//  Created by 박서연 on 2024/07/01.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct BannerCircleComponent: View {
    let count: Int
    @Binding var currentIndex: Int
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<count, id: \.self) { index in
                Circle()
                    .fill(index == abs(currentIndex) ? Color.primaryFF6972 : Color.neutral300)
                    .frame(width: 6, height: 6)
            }
        }
    }
}

#Preview {
    BannerCircleComponent(count: 5, currentIndex: .constant(1))
}
