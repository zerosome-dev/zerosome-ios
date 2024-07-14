//
//  CustomTextEditor.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/09.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import UIKit

public struct DynamicHeightTextEditor: View {
    @Binding public var text: String
    @Binding public var dynamicHeight: CGFloat
    public let initialHeight: CGFloat
    public let radius: CGFloat
    public let font: ZSFont
    public let backgroundColor: Color
    public let fontColor: Color
    public let placeholder: String
    public let placeholderColor: Color
    
    public init(text: Binding<String>,
         dynamicHeight: Binding<CGFloat>,
         initialHeight: CGFloat,
         radius: CGFloat,
         font: ZSFont,
         backgroundColor: Color,
         fontColor: Color,
         placeholder: String,
         placeholderColor: Color) {
        self._text = text
        self._dynamicHeight = dynamicHeight
        self.initialHeight = initialHeight
        self.radius = radius
        self.font = font
        self.backgroundColor = backgroundColor
        self.fontColor = fontColor
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
    }
    
    public var body: some View {
        VStack(spacing: 6) {
            UITextViewWrapper(text: $text,
                              dynamicHeight: $dynamicHeight,
                              font: .body2,
                              backgroundColor: UIColor(backgroundColor),
                              fontColor: UIColor(fontColor),
                              placeholder: "제품에 대한 의견을 자유롭게 남겨주세요.",
                              placeholderColor: UIColor(placeholderColor))
                .frame(minHeight: initialHeight, maxHeight: dynamicHeight)
                .cornerRadius(8)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(text.isEmpty ? Color.neutral100 : Color.neutral300)
                }
            
            Text("\(text.count)/1000")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .applyFont(font: .label1)
                .foregroundStyle(Color.neutral400)
                .onChange(of: text) { newValue in
                    if newValue.count > 1000 {
                        text = String(newValue.prefix(100))
                    }
                }
        }
    }
}

fileprivate struct UITextViewWrapper: UIViewRepresentable {
    @Binding fileprivate var text: String
    @Binding fileprivate var dynamicHeight: CGFloat
    fileprivate let font: ZSFont
    fileprivate let backgroundColor: UIColor
    fileprivate let fontColor: UIColor
    fileprivate let placeholder: String
    fileprivate let placeholderColor: UIColor
    
    fileprivate init(text: Binding<String>,
         dynamicHeight: Binding<CGFloat>,
         font: ZSFont,
         backgroundColor: UIColor,
         fontColor: UIColor,
         placeholder: String,
         placeholderColor: UIColor) {
        self._text = text
        self._dynamicHeight = dynamicHeight
        self.font = font
        self.backgroundColor = backgroundColor
        self.fontColor = fontColor
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
    }

    fileprivate func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.font = font.toUIFont
        textView.delegate = context.coordinator
        textView.backgroundColor = backgroundColor
        textView.textColor = fontColor
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        
        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholder
        placeholderLabel.font = font.toUIFont
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.addSubview(placeholderLabel)
        textView.setValue(placeholderLabel, forKey: "_placeholderLabel")
                
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 10),
            placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 12),
            placeholderLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -12)
        ])
        updatePlaceholderVisibility(textView: textView)
        
        return textView
    }

    fileprivate func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        recalculateHeight(view: uiView)
    }

    fileprivate func recalculateHeight(view: UITextView) {
        let size = view.sizeThatFits(CGSize(width: view.frame.width, height: CGFloat.greatestFiniteMagnitude))
        if dynamicHeight != size.height {
            DispatchQueue.main.async {
                self.dynamicHeight = size.height
            }
        }
    }

    fileprivate func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    fileprivate class Coordinator: NSObject, UITextViewDelegate {
        var parent: UITextViewWrapper

        init(_ parent: UITextViewWrapper) {
            self.parent = parent
        }

        fileprivate func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            parent.recalculateHeight(view: textView)
        }
    }
    
    fileprivate func updatePlaceholderVisibility(textView: UITextView) {
        if let placeholderLabel = textView.value(forKey: "_placeholderLabel") as? UILabel {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }
}
