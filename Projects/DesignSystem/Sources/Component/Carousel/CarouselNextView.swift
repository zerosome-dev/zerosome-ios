//
//  CarouselNextView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/07/17.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public struct CarouselNextView<Data: Identifiable, Content: View, LastContent: View>: View {
    
    @Binding var width: CGFloat
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
                let baseOffset = contentSpacing + edgeSpacing - totalSpacing
                let total: CGFloat = geometry.size.width + totalSpacing * 2
                let contentWidth = total - (edgeSpacing * 2) - (contentSpacing * 2)
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
                                .onEnded { value in
//                                    let offsetX = value.translation.width
//                                    
//                                    if offsetX < -50 { // 오른쪽으로 스와이프
//                                        currentIndex = min(currentIndex + 1, CGFloat(data.count))
//                                    } else if offsetX > 50 { // 왼쪽으로 스와이프
//                                        currentIndex = max(currentIndex - 1, 0)
//                                    }
//                                    
//                                    withAnimation {
//                                        currentOffset = -currentIndex * nextOffset
//                                    }
                                    let offsetX = value.translation.width
                                    let velocityX = value.velocity.width
                                    
                                    let swipeThreshold: CGFloat = velocityX > 1000 ? 20 : 50 // 속도에 따라 조건 조절
                                    
                                    if offsetX < -swipeThreshold {
                                        currentIndex = min(currentIndex + 1, CGFloat(data.count-1))
                                    } else if offsetX > swipeThreshold {
                                        currentIndex = max(currentIndex - 1, 0)
                                    }
                                    
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        currentOffset = -currentIndex * nextOffset
                                    }
                                }
                        )
                    }
                }
                .offset(x: currentOffset + (currentIndex > 0 ? baseOffset : 0))
                .onAppear {
                    width = contentWidth
                }
            }
        }
    }
}
