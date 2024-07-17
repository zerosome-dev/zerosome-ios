//
//  MypageButton.swift
//  App
//
//  Created by 박서연 on 2024/07/17.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct MypageButton: View {
    let title: String
    var action: (() -> Void)?
    
    var body: some View {
        Text(title)
            .applyFont(font: .body3)
            .foregroundStyle(Color.neutral400)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.neutral100)
            }
            .onTapGesture {
                action?()
            }
    }
}

extension MypageButton {
    func tap(_ action: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.action = action
        return copy
    }
}
