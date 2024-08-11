//
//  SingleTermView.swift
//  App
//
//  Created by 박서연 on 2024/06/19.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct SingleTermView: View {
    @Binding var isChecked: Bool
    var term: Term
    var tapTitle: ((Term) -> Void)?
    
    init(
        isChecked: Binding<Bool>,
        term: Term,
        tapTitle: ((Term) -> Void)? = nil
    ) {
        self._isChecked = isChecked
        self.term = term
        self.tapTitle = tapTitle
    }
    
    var body: some View {
        HStack(spacing: 12) {
            (
                isChecked
                ? ZerosomeAsset.ic_check_circle_primary
                : ZerosomeAsset.ic_check_circle_gray
            )
            .resizable()
            .frame(width: 24, height: 24)
            .onTapGesture {
                isChecked.toggle()
            }
                
            Text(term.title)
                .applyFont(font: .body1)
                .foregroundStyle(Color.neutral800)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            Text("보기")
                .applyFont(font: .body2)
                .foregroundStyle(Color.neutral400)
                .onTapGesture {
                    tapTitle?(term)
                }
        }
    }
}

extension SingleTermView {
    func tap (action: @escaping ((Term) -> Void)) -> Self {
        var copy = self
        copy.tapTitle = action
        return copy
    }
}

#Preview {
    SingleTermView(isChecked: .constant(true), term: .term, tapTitle: { _ in print("tapped")})
}
