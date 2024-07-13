//
//  ToastView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/07/13.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public enum ToastType {
    case success
    case warning
    
    var image: Image {
        switch self {
        case .success:
            return ZerosomeAsset.ic_check_circle_green
        case .warning:
           return ZerosomeAsset.ic_warning_circle_caption
        }
    }
}

public struct ToastView: View {
    public let type: ToastType
    public let desc: String
    
    public var body: some View {
        HStack(spacing: 12) {
            type.image
                .resizable()
                .frame(width: 24, height: 24)
            
            Text(desc)
                .foregroundStyle(.white)
                .applyFont(font: .body1)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.init(top: 15.5, leading: 16, bottom: 15.5, trailing: 16))
        .background(Color.neutral500)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

public struct ToastViewModifier: ViewModifier {
    @Binding var isShowing: Bool
    let type: ToastType
    let desc: String
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
            
            if isShowing {
                ToastView(type: type, desc: desc)
                    .padding(.horizontal, 24)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isShowing = false
                            }
                        }
                    }
            }
        }
    }
}

public extension View {
    func ZToast(_ isShowing: Binding<Bool>,
                _ type: ToastType,
                _ desc: String) -> some View
    {
        self.modifier(ToastViewModifier(isShowing: isShowing, type: type, desc: desc))
    }
}

#Preview {
    ToastView(
              type: .success,
              desc: "리뷰가 삭제되었습니다.")
}
