//
//  TextInput.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/20.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public struct TextInput: View {
    public var text: Binding<String>
    public var placeholder: String = ""
    public var trailingImage: Image?
    public var tapTrailingImage: (() -> Void)?
    public var maxCount: Int?
    public var minCount: Int?
    public var isError: Bool = false
    public var font: ZSFont = .body2
    public var placeholderFont: ZSFont = .body2

    public init(text: Binding<String>) {
        self.text = text
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            TextField(
                "",
                text: text,
                prompt: Text(placeholder)
                    .font(placeholderFont.toFont)
                    .foregroundColor(Color.gray),
                    
                axis: .horizontal
            )
            .font(font.toFont)
            .foregroundStyle(getTextColor())
            .padding(.init(top: 13, leading: 12, bottom: 13, trailing: 12))
            .disableAutocorrection(true)
            .onReceive(text.wrappedValue.publisher.collect()) {
                if let maxCount {
                    var s = String($0.prefix(maxCount))
                    s = s.filter { !$0.isWhitespace }
                    if text.wrappedValue != s && (maxCount != 0) {
                        text.wrappedValue = s
                    }
                }
            }
            
            if text.wrappedValue.count > 0, tapTrailingImage != nil, trailingImage != nil {
                trailingImage!
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(14)
                    .onTapGesture {
                        tapTrailingImage?()
                    }
            }
        }.background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.neutral300, lineWidth: 1)
        )
    }

    private func getTextColor() -> Color {
        return Color.neutral700
    }
}

public extension TextInput {
    func maxCount(_ count: Int) -> Self {
        var copy = self
        copy.maxCount = count
        return copy
    }
    
    func setError(_ isError: Bool) -> Self {
        var copy = self
        copy.isError = isError
        return copy
    }
    
    func tapTrailingImage(action: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.tapTrailingImage = action
        return copy
    }
    
    func font(_ font: ZSFont) -> Self {
        var copy = self
        copy.font = font
        return copy
    }
    
    func placeholder(_ placeholder: String) -> Self {
        var copy = self
        copy.placeholder = placeholder
        return copy
    }
    
    func placeholderFont(_ font: ZSFont) -> Self {
        var copy = self
        copy.placeholderFont = font
        return copy
    }
}
