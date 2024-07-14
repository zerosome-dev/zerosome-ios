//
//  ChipsContainerView.swift
//  App
//
//  Created by 박서연 on 2024/07/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public struct ChipsView: View {
    
    let checkList: [String]
    let check: Bool
    let title: String
    
    init(
        checkList: [String],
        check: Bool,
        title: String
    ) {
        self.checkList = checkList
        self.check = check
        self.title = title
    }
    
    public var body: some View {        
        Text(title)
            .applyFont(font: .body2)
            .padding(.init(top: 6, leading: 12, bottom: 6, trailing: 12))
            .background(check ? Color.primaryFF6972 : .white)
            .foregroundStyle(check ? .white : .black)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(check ? Color.primaryFF6972
                            : Color.neutral200, lineWidth: 1)
            )
    }
}

public struct ChipsContainerView: View {

    @Binding var array: [String]
    @State var totalHeight: CGFloat
    let verticalSpacing: CGFloat
    let horizontalSpacing: CGFloat
    let types: [ZeroDrinkSampleData]
    var sortedTypes: [ZeroDrinkSampleData] {
        types.sorted(by: { $0.name < $1.name })
    }
    
    public init(
        array: Binding<[String]>,
        totalHeight: CGFloat = .zero,
        verticalSpacing: CGFloat = 10,
        horizontalSpacing: CGFloat = 10,
        types: [ZeroDrinkSampleData]
    ) {
        self._array = array
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
                    ChipsView(checkList: array, check: returnResult(of: type.name), title: type.name)
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
        if let existingIndex = array.firstIndex(of: index) {
            array.remove(at: existingIndex)
        } else {
            array.append(index)
        }
    }
    
    private func returnResult(of index: String) -> Bool {
        return array.contains(index) ? true : false
    }
}

//#Preview {
////    ChipsContainerView(types: ZeroDrinkSampleData.data)
//    ChipsContainerView(array: <#T##[String]#>, result: <#T##Bool#>, totalHeight: <#T##CGFloat#>, verticalSpacing: <#T##CGFloat#>, horizontalSpacing: <#T##CGFloat#>, types: <#T##[ZeroDrinkSampleData]#>)
//}
