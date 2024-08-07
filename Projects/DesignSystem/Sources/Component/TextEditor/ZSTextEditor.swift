//
//  ZSTextEditor.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/07/18.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public struct ZSTextEditor: View {
    @Binding public var content: String
    public let placeholder: String
    public let maxCount: Int
    
    public init(
        content: Binding<String>,
        placeholder: String,
        maxCount: Int
    ) {
        self._content = content
        self.placeholder = placeholder
        self.maxCount = maxCount
    }
    
    public var body: some View {
        VStack {
            VStack(spacing: 6) {
                TextEditor(text: $content)
                    .frame(height: 100)
                    .applyFont(font: .body2)
                    .foregroundStyle(Color.neutral700)
                    .padding(.init(top: 2,leading: 7,bottom: 2,trailing: 7))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(content.isEmpty ? Color.neutral100 : Color.neutral300)
                    }
                    .overlay(alignment: .topLeading) {
                        ZSText(placeholder, fontType: .body2, color: Color.neutral200)
                            .padding(.init(top: 10,leading: 12,bottom: 10,trailing: 12))
                            .opacity(content.isEmpty ? 1 : 0)
                    }
                    .onReceive(content.publisher.collect(), perform: { input in
                        content = String(input.prefix(maxCount))
                    })
                
                ZSText("\(content.count)/\(maxCount)", fontType: .body4)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 2)
                    .foregroundStyle(Color.neutral400)
            }
        }
    }
}
