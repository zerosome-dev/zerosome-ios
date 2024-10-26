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
    @StateObject private var viewModel = MypageInfoViewModel()
    @ObservedObject var vm: MypageViewModel
    var body: some View {
        VStack {
            ZSText("고객센터", fontType: .body3, color: Color.neutral300)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
                .padding(.top, 20)
            
            ForEach(CustomCenter.allCases, id: \.self) { center in
                HStack {
                    ZSText(center.rawValue, fontType: .body3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    ZerosomeAsset.ic_arrow_after
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .contentShape(Rectangle())
                .padding(.bottom, 10)
                .onTapGesture {
                    if center == .inquiry {
                        vm.send(.linkKakao)
                    } else {
                        viewModel.send(.customURL(center))
                    }
                }
            }
            
            DivideRectangle(height: 1, color: Color.neutral100)
            
            ZSText("서비스 이용", fontType: .body3, color: Color.neutral300)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
                .padding(.top, 20)
            
            ForEach(Service.allCases, id: \.self) { service in
                HStack {
                    ZSText(service.rawValue, fontType: .body3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    if service == .appVersion {
                        ZSText(service.url, fontType: .body2, color: Color.neutral500)
                    } else {
                        ZerosomeAsset.ic_arrow_after
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                .contentShape(Rectangle())
                .padding(.bottom, 10)
                .onTapGesture {
                    viewModel.send(.serviceURL(service))
                }
            }
        }
        .padding(.horizontal, 22)
    }
}

