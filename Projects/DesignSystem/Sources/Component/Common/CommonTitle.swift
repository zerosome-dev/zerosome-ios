//
//  CommonTitle.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/07/01.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public enum Title {
    case solo
    case text
    case image
}

public struct CommonTitle: View {
    public let title: String
    public let type: Title
    public let buttonTitle: String?
    public var buttonAction: (() -> Void)?
    public let imageTitle: Image?
    public var imageAction: (() -> Void)?
    
    public init(title: String,
                type: Title,
                buttonTitle: String? = nil,
                buttonAction: (() -> Void)? = nil,
                imageTitle: Image? = nil,
                imageAction: (() -> Void)? = nil)
    {
        self.title = title
        self.type = type
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
        self.imageTitle = imageTitle
        self.imageAction = imageAction
    }
    
    public var body: some View {
        switch type {
        case .solo:
            Text(title)
                .applyFont(font: .heading2)
                .foregroundStyle(Color.neutral900)
                .frame(maxWidth: .infinity, alignment: .leading)
            
        case .text:
            HStack {
                Text(title)
                    .applyFont(font: .heading2)
                    .foregroundStyle(Color.neutral900)
                Spacer()
                Text(buttonTitle ?? "중복 선택 불가")
                    .foregroundStyle(Color.neutral500)
                    .applyFont(font: .body3)
//                    .onTapGesture {
//                        buttonAction?()
//                    }
            }
            .contentShape(Rectangle())
        case .image:
            HStack {
                Text(title)
                    .applyFont(font: .heading2)
                    .foregroundStyle(Color.neutral900)
                Spacer()
                imageTitle?
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                imageAction?()
            }  
        }
    }
}

public extension CommonTitle {
    func buttonAction(action: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.buttonAction = action
        return copy
    }
    
    func imageAction (action: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.imageAction = action
        return copy
    }
}


#Preview {
    CommonTitle(title: "title", type: .solo, buttonTitle: nil)
}
