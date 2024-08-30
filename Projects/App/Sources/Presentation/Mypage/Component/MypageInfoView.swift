//
//  MypageInfoView.swift
//  App
//
//  Created by 박서연 on 2024/08/30.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct MypageInfoView: View {
    var body: some View {
        VStack {
            ForEach(MypageCenter.allCases, id: \.self) { center in
                Text(center.rawValue)
                    .applyFont(font: .body3)
                    .foregroundStyle(Color.neutral300)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                    .padding(.top, 20)
                
                ForEach(center.type, id: \.self) { type in
                    HStack {
                        Text(type)
                            .applyFont(font: .body2)
                            .foregroundStyle(Color.neutral900)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        if type == MypageCenter.service.type.last! {
                            Text("앱 버전1.201.23")
                                .applyFont(font: .body2)
                                .foregroundStyle(Color.neutral500)
                        } else {
                            ZerosomeAsset.ic_arrow_after
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                        
                    }
                    .onTapGesture {
                        print("case 별로 이동 처리 추가 예정")
                    }
                }
                .padding(.bottom, 10)
                DivideRectangle(height: 1, color: Color.neutral100)
            }
        }
        .padding(.horizontal, 22)
    }
}
