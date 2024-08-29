//
//  ChipsContainerView.swift
//  App
//
//  Created by 박서연 on 2024/07/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public struct ChipsView: View {
    
    let check: Bool
    let title: String
    let tappedChips: [TappedChips]
    
    init(
        check: Bool,
        title: String,
        tappedChips: [TappedChips]
    ) {
        self.check = check
        self.title = title
        self.tappedChips = tappedChips
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

struct ChipsContainerView<T: ChipRepresentable>: View {

    @Binding var tappedChips: [TappedChips]
    @State var totalHeight: CGFloat
    let verticalSpacing: CGFloat
    let horizontalSpacing: CGFloat
    let types: [T]
    
    public init(
        tappedChips: Binding<[TappedChips]>,
        totalHeight: CGFloat = .zero,
        verticalSpacing: CGFloat = 10,
        horizontalSpacing: CGFloat = 10,
        types: [T]
    ) {
        self._tappedChips = tappedChips
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
                ForEach(types, id: \.code) { type in
                    ChipsView(check: checkCipsList(chip: TappedChips(name: type.name, code: type.code)), title: type.name, tappedChips: tappedChips)
                        .onTapGesture {
                            appendChips(name: type.name, code: type.code)
                        }
                        .alignmentGuide(.leading) { view in
                            guard let last = types.last else { return 0 }
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
                            guard let last = types.last else { return 0 }
                            
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

    private func appendChips(name: String, code: String) {
        let chip = TappedChips(name: name, code: code)
        
        if let existedChip = tappedChips.firstIndex(of: chip) {
            tappedChips.remove(at: existedChip)
        } else {
            tappedChips.append(chip)
        }
    }
    
    private func checkCipsList(chip: TappedChips) -> Bool {
        return tappedChips.contains(chip) ? true : false
    }
}
