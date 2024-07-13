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
    let types: [ZeroDrinkSampleData]
    var sortedTypes: [ZeroDrinkSampleData] {
        types.sorted(by: { $0.name < $1.name })
    }
    public init(
        totalHeight: CGFloat = .zero,
        verticalSpacing: CGFloat = 10,
        horizontalSpacing: CGFloat = 10,
        types: [ZeroDrinkSampleData]
    ) {
        self.totalHeight = totalHeight
        self.verticalSpacing = verticalSpacing
        self.horizontalSpacing = horizontalSpacing
        self.types = types
    }
    
    public var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        GeometryReader { geomety in
            ZStack(alignment: .topLeading) {
                ForEach(sortedTypes, id: \.id) { type in
                    ChipsView(title: type.name, viewModel: viewModel)
                        .onTapGesture {
                            toggleSelection(of: type.name)
                        }
                        .alignmentGuide(.leading) { view in
                            guard let last = sortedTypes.last else { return 0 }
                            if abs(width - view.width) > geomety.size.width {
                                width = 0
                                height -= view.height
                                height -= verticalSpacing
                            }
                            let result = width
                            
                            if type == last {
                                width = 0
                            } else {
                                width -= view.width
                                width -= horizontalSpacing
                            }
//                            
                            return result
                        }
                        .alignmentGuide(.top) { _ in
                            guard let last = sortedTypes.last else { return 0 }
                            
                            let result = height
                            
                            if type == last {
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
    ChipsContainerView(types: ZeroDrinkSampleData.data)
}
