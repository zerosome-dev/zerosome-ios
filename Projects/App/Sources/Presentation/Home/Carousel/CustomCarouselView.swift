//
//  CustomCarouselView.swift
//  App
//
//  Created by 박서연 on 2024/06/05.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct CustomCarouselView<Content: View>: View {
    
    let pageCount: Int
    let pageSpacing: CGFloat
    let edgeSpacing: CGFloat
    let cardSpacing: CGFloat
    let content: (Int) -> Content
    
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    init(pageCount: Int,
         pageSpacing: CGFloat,
         edgeSpacing: CGFloat,
         cardSpacing: CGFloat,
         @ViewBuilder content: @escaping (Int) -> Content) {
        self.pageCount = pageCount
        self.pageSpacing = pageSpacing
        self.edgeSpacing = edgeSpacing
        self.cardSpacing = cardSpacing
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let contentWidth = width - (pageSpacing * 2)
            
            HStack(spacing: cardSpacing) {
                ForEach(0..<pageCount, id: \.self) { index in
                    self.content(index)
                        .frame(width: contentWidth)
                }
            }
            .offset(x: -(width - (pageSpacing * 2) + cardSpacing) * CGFloat(currentIndex) + offset)
            .gesture(
                DragGesture()
                    .updating($offset) { value, state, _ in
                        state = value.translation.width
                    }
                    .onEnded { value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        currentIndex = max(min(currentIndex + Int(roundIndex), pageCount - 1), 0)
                    }
            )
            .animation(.easeInOut, value: currentIndex)
            .padding(.horizontal, pageSpacing)
        }
    }
}

#Preview {
    CustomCarouselView(pageCount: 10,
                       pageSpacing: 20,
                       edgeSpacing: 12,
                       cardSpacing: 8) { index in
        let item = Sample.sample[index]
        
        Rectangle()
            .fill(item.color)
            .overlay {
                VStack {
                    Text(item.id)
                    Text(item.name)
                }
            }
            .frame(height: 200)
        
    }
}

struct Sample {
    let id: String = UUID().uuidString
    let name: String
    let color: Color
    
    static let sample: [Sample] = [
        .init(name: "AA", color: .red),
        .init(name: "BB", color: .orange),
        .init(name: "CC", color: .yellow),
        .init(name: "DD", color: .green),
        .init(name: "EE", color: .blue),
        .init(name: "FF", color: .cyan),
        .init(name: "HH", color: .purple),
        .init(name: "II", color: .brown),
        .init(name: "JJ", color: .gray),
        .init(name: "KK", color: .black)
    ]
}

