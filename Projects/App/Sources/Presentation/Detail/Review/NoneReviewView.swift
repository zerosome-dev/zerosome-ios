//
//  NoneReviewView.swift
//  App
//
//  Created by 박서연 on 2024/07/02.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct NoneReviewView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack(spacing: 12) {
            ZSText("첫 리뷰를 작성해보세요!", fontType: .heading2, color: Color.neutral700)
            
            ZSText("리뷰 작성하러 가기", fontType: .body1, color: Color.neutral900)
                .padding(.init(top: 10,leading: 20,bottom: 10,trailing: 20))
                .background(Color.neutral50)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .onTapGesture {
                    print("리뷰 작성하러 가기 라우터 연결")
                }
        }
    }
}

#Preview {
    NoneReviewView()
}
