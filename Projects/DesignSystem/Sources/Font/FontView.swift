//
//  FontView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/05/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct FontView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Pretendard Heading1")
                .font(.system(size: 20))
            
            Text("Pretendard Heading1")
                .applyFont(font: .heading1)
            
            Text("Pretendard Heading2")
                .applyFont(font: .heading2)
            
            ZSText("Pretendard Heading2", fontType: .heading2, color: .negative)
        }
    }
}

#Preview {
    FontView()
}
