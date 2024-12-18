//
//  MypagePopup.swift
//  App
//
//  Created by 박서연 on 2024/07/17.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct MypagePopup: View {
    var updateAction: (() -> Void)?
    var removeAction: (() -> Void)?
    
    init(
        updateAction: (() -> Void)? = nil,
        removeAction: (() -> Void)? = nil
    ) {
        self.updateAction = updateAction
        self.removeAction = removeAction
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.white)
            .frame(width: 89, height: 88)
            .shadow(color: .black.opacity(0.1), radius: 12, y: 4)
            .overlay {
                VStack(spacing: 0) {
                    Text("수정")
                        .padding(.vertical, 12)
                        .onTapGesture {
                            updateAction?()
                        }
                    
                    DivideRectangle(height: 1, color: Color.neutral200)
                    
                    Text("삭제")
                        .padding(.vertical, 12)
                        .onTapGesture {
                            removeAction?()
                        }
                }
                .applyFont(font: .body2)
                .foregroundStyle(Color.neutral900)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.neutral200)
            }
    }
}

extension MypagePopup {
    func tapRemove(_ removeAction: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.removeAction = removeAction
        return copy
    }
    
    func tapUpdate(_ updateAction: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.updateAction = updateAction
        return copy
    }
}

#Preview {
    MypagePopup()
}
