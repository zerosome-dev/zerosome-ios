//
//  ChipsContainerView.swift
//  App
//
//  Created by 박서연 on 2024/07/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public struct ChipsView: View {

    @ObservedObject var viewModel: CategoryViewModel
    var title: String
    
    init(
        title: String,
        viewModel: CategoryViewModel
    ) {
        self.title = title
        self.viewModel = viewModel
    }
    
    public var body: some View {
        let result = viewModel.zeroTag.contains(title)
        
        Text(title)
            .applyFont(font: .body2)
            .padding(.init(top: 6, leading: 12, bottom: 6, trailing: 12))
            .background(result ? Color.primaryFF6972 : .white)
            .foregroundStyle(result ? .white : .black)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(result ? Color.primaryFF6972
                            : Color.neutral200, lineWidth: 1)
            )
    }
}

public struct ChipsContainerView: View {
    @ObservedObject private var viewModel = CategoryViewModel()
    @State var totalHeight: CGFloat
    let verticalSpacing: CGFloat
    let horizontalSpacing: CGFloat
    let items: [ChipsType]
    var sortedItems: [ChipsType] {
        items.sorted(by: { $0.priority < $1.priority })
    }
    
    public init(
        totalHeight: CGFloat = .zero,
        verticalSpacing: CGFloat = 10,
        horizontalSpacing: CGFloat = 10,
        items: [ChipsType]
    ) {
        self.totalHeight = totalHeight
        self.verticalSpacing = verticalSpacing
        self.horizontalSpacing = horizontalSpacing
        self.items = items
    }
    
    public var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        GeometryReader { geomety in
            ZStack(alignment: .topLeading) {
                ForEach(self.sortedItems, id: \.title) { item in
                    ChipsView(title: item.title, viewModel: viewModel)
                        .onTapGesture {
                            toggleSelection(of: item.title)
                        }
                        .id(item.title)
                        .alignmentGuide(.leading) { view in
                            if abs(width - view.width) > geomety.size.width {
                                width = 0
                                height -= view.height
                                height -= verticalSpacing
                            }
                            let result = width
                            
                            if item == sortedItems.last {
                                width = 0
                            } else {
                                width -= view.width
                                width -= horizontalSpacing
                            }
                            
                            return result
                        }
                        .alignmentGuide(.top) { _ in
                            let result = height
                            
                            if item == sortedItems.last {
                                height = 0
                            }
                            return result
                        }
                }
            }
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            self.totalHeight = geometry.size.height
                        }
                }
            )
        }
        .frame(height: totalHeight)
    }
    
    private func toggleSelection(of index: String) {
        if let existingIndex = viewModel.zeroTag.firstIndex(of: index) {
            viewModel.zeroTag.remove(at: existingIndex)
        } else {
            viewModel.zeroTag.append(index)
        }
    }
}

#Preview {
    ChipsContainerView( items: [
        .init(title: "첫번째"),
        .init(title: "두번째", priority: 1),
        .init(title: "세번째", priority: 2),
        .init(title: "네번째", priority: 3),
        .init(title: "서른마흔다섯번째", priority: 4),
        .init(title: "여섯번째", priority: 5),
        .init(title: "일곱번째", priority: 6),
        .init(title: "여덟번째", priority: 7),
        .init(title: "아홉번째", priority: 8),
    ])
}
