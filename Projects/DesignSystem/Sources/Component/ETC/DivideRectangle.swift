//
//  DivideRectangle.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/09.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public struct DivideRectangle: View {
    public let height: CGFloat
    public let color: Color
    
    public init(height: CGFloat, color: Color) {
        self.height = height
        self.color = color
    }
    
    public var body: some View {
        Rectangle()
            .fill(color)
            .frame(maxWidth: .infinity)
            .frame(height: height)
    }
}

#Preview {
    DivideRectangle(height: 1, color: Color.neutral50)
}
