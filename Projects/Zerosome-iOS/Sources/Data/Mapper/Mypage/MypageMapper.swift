//
//  MypageMapper.swift
//  App
//
//  Created by 박서연 on 2024/08/29.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

class MypageMapper {
    static func toMemberBasicInfo(response: MemberBasicInfoResponseDTO) -> MemberBasicInfoResult {
        return MemberBasicInfoResult(
            nickname: response.nickname ?? "",
            reviewCnt: response.reviewCnt ?? 0
        )
    }
}
