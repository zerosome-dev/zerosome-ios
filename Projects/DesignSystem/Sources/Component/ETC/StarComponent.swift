//
//  StarComponent.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/07/01.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public struct StarComponent: View {
    public let rating: Double
    public let size: CGFloat
    
    public init(
        rating: Double,
        size: CGFloat
    ) {
        self.rating = rating
        self.size = size
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<5, id: \.self) { index in
                (index < Int(round(rating)) ? ZerosomeAsset.ic_star_fill : ZerosomeAsset.ic_star_empty)
                    .resizable()
                    .frame(width: size, height: size)
            }
        }
    }
}
