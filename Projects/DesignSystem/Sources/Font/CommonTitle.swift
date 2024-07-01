//
//  CommonTitle.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/07/01.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public struct CommonTitle: View {
    public let title: String
    
    public init(title: String) {
        self.title = title
    }
    
    public var body: some View {
        Text(title)
            .applyFont(font: .heading2)
            .foregroundStyle(Color.neutral900)
    }
}

#Preview {
    CommonTitle(title: "title")
}
