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
    var checkMarketing: (() -> Bool)?
    var termPage: ((Term) -> Void)?
    
    init(
        isChecked: Binding<Bool>,
        term: Term,
        checkMarketing: (() -> Bool)? = nil,
        termPage: ((Term) -> Void)? = nil
    ) {
        self._isChecked = isChecked
        self.term = term
        self.checkMarketing = checkMarketing
        self.termPage = termPage
    }
    
    var body: some View {
        HStack {
            HStack(spacing: 12) {
                (
                    isChecked
                    ? ZerosomeAsset.ic_check_circle_primary
                    : ZerosomeAsset.ic_check_circle_gray
                )
                .resizable()
                .frame(width: 24, height: 24)
                
                ZSText(term.title, fontType: .body1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .onTapGesture {
                isChecked.toggle()
            }
            
            ZSText("보기", fontType: .body2, color: Color.neutral400)
                .onTapGesture {
                    termPage?(term)
                }
        }
    }
}

extension SingleTermView {
    func tap (action: @escaping ((Term) -> Void)) -> Self {
        var copy = self
        copy.termPage = action
        return copy
    }
}

#Preview {
    SingleTermView(isChecked: .constant(true), term: .term)
}
