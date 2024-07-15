//
//  CarouselView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/07/15.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public struct CarouselSecondView<Data: Identifiable, Content: View, LastContent: View>: View {
    
    @Binding public var width: CGFloat
    public let data: [Data]
    public let edgeSpacing: CGFloat
    public let contentSpacing: CGFloat
    public let totalSpacing: CGFloat
    public let contentHeight: CGFloat
    
    public let carouselContent: (Data) -> Content
    public let lastContent: () -> LastContent
    
    @State public var currentIndex: CGFloat = 0
    @State public var currentOffset: CGFloat = 0
    
    public init(
        width: Binding<CGFloat>,
        data: [Data],
        edgeSpacing: CGFloat,
        contentSpacing: CGFloat,
        totalSpacing: CGFloat,
        contentHeight: CGFloat,
        @ViewBuilder carouselContent: @escaping (Data) -> Content,
        @ViewBuilder lastContent: @escaping () -> LastContent
        
    ) {
        self._width = width
        self.data = data
        self.edgeSpacing = edgeSpacing
        self.contentSpacing = contentSpacing
        self.totalSpacing = totalSpacing
        self.contentHeight = contentHeight 
        self.carouselContent = carouselContent
        self.lastContent = lastContent
    }
    
    public var body: some View {
        VStack {
            GeometryReader { geometry in
                let size = geometry.size
                let contentWidth = size.width - (edgeSpacing * 2)
                let nextOffset = contentWidth + contentSpacing
                
                HStack(spacing: contentSpacing) {
                    ForEach(0...data.count, id: \.self) { index in
                        Group {
                            if index == data.count {
                                lastContent()
                            } else {
                                carouselContent(data[index])
                            }
                        }
                        .frame(width: contentWidth, height: contentHeight)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    
                                }
                                .onEnded { value in
                                    let offsetX = value.translation.width
                                    
                                    if offsetX < -50 {
                                        currentIndex = min(currentIndex + 1, CGFloat(data.count))
                                    } else if offsetX > 50 {
                                        currentIndex = max(currentIndex - 1, 0)
                                    }
                                    
                                    withAnimation {
                                        currentOffset = -currentIndex * nextOffset
                                    }
                                }
                        )
                    }
                }
                .offset(x: currentOffset + (currentIndex == 0 ? 0 : edgeSpacing))
                .onAppear {
                    width = contentWidth
                }
            }
        }
        .padding(.horizontal, totalSpacing)
    }
}
