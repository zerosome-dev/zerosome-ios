//
//  BannerTest2.swift
//  App
//
//  Created by 박서연 on 2024/07/01.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct CustomInfiniteBanner: View {
    @State private var currentIndex = 0
    @State private var currentOffset: CGFloat = 0
    
    let data: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
    let height: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            HStack(spacing: 0) {
                ForEach(data, id: \.self) { color in
                    Rectangle()
                        .fill(color)
                        .frame(width: size.width, height: height)
                        .gesture (
                            DragGesture()
                                .onEnded { value in
                                    if value.translation.width > 100 { // 사진 왼쪽으로 넘김
                                        if abs(currentIndex) == 0 { // 맨뒤까지 갔을 때 스크롤 하면 처음으로 이동
                                            currentIndex = -5
                                            currentOffset = -(CGFloat(data.count - 1) * size.width)
                                        } else {
                                            currentIndex += 1
                                            currentOffset += size.width
                                        }
                                    } else if value.translation.width < -100 { // 사진 오른쪽으로 넘김
                                        currentIndex -= 1
                                        currentOffset -= size.width
                                        
                                        if abs(currentIndex) == data.count { // 맨뒤까지 갔을 때 스크롤 하면 처음으로 이동
                                            currentIndex = 0
                                            currentOffset = 0
                                        }
                                    }
                                }
                        )
                }
                .offset(x: currentOffset)
                .animation(.easeIn, value: abs(currentIndex))
            }
        }
        .frame(height: height)
        .overlay(alignment: .bottom) {
            BannerCircleComponent(count: data.count-1, currentIndex: $currentIndex)
                .padding(.bottom, 30)
        }
    }
}

#Preview {
    CustomInfiniteBanner(height: 200)
}
