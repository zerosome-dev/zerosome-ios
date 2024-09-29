//
//  UserInfoView.swift
//  App
//
//  Created by 박서연 on 2024/07/17.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct UserInfoView: View {
    @ObservedObject var viewModel: MypageViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var nickname: (() -> Void)?
    var action: (() -> Void)?
    
    init(
        viewModel: MypageViewModel,
        nickname: (() -> Void)? = nil,
        action: (() -> Void)? = nil
    ) {
        self.viewModel = viewModel
        self.nickname = nickname
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                ZSText(authViewModel.userInfo?.nickname ?? viewModel.userInfo.nickname, fontType: .subtitle1)
                Spacer()
                ZSText("닉네임 변경", fontType: .body3, color: Color.neutral600)
                    .padding(.init(top: 6,leading: 10, bottom: 6, trailing: 10))
                    .background(Color.neutral50)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        nickname?()
                    }
            }
            
            let reviewCnt = authViewModel.userInfo?.reviewCnt ?? viewModel.userInfo.reviewCnt
            ZSText((reviewCnt == 0
                    ? "아직 작성한 리뷰가 없어요"
                    : "작성한 리뷰 (\(reviewCnt))"),
                   fontType: .subtitle2,
                   color: reviewCnt == 0 ? Color.neutral800 : Color.white
            )
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(reviewCnt == 0 ? Color.primaryFF6972.opacity(0.1) : Color.primaryFF6972)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .onTapGesture {
                action?()
            }
            .disabled(viewModel.userInfo.reviewCnt == 0 ? true : false)
        }
        .padding(.horizontal, 22)
    }
}

extension UserInfoView {
    func tapAction(_ action: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.action = action
        return copy
    }
    
    func tapNickname(_ nickname: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.nickname = nickname
        return copy
    }
}

#Preview {
    UserInfoView(viewModel: MypageViewModel(mypageUseCase: MypageUsecase(mypageRepoProtocol: MypageRepository(apiService: ApiService()))))
}
