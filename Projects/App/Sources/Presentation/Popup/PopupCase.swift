//
//  PopupCase.swift
//  App
//
//  Created by 박서연 on 2024/09/02.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

enum DoublePopup {
    case none
    case deleteReview
    case reportReview
    case logout
    case revoke
    
    var title: String {
        switch self {
        case .none:
            return ""
        case .deleteReview:
            return "리뷰를 삭제할까요?"
        case .reportReview:
            return "신고할까요?"
        case .revoke:
            return "회원 탈퇴하시겠어요?"
        case .logout:
            return "로그아웃 하시겠어요?"
        }
    }
    
    var subtitle: String {
        switch self {
        case .none:
            ""
        case .deleteReview:
            ""
        case .reportReview:
            ""
        case .revoke:
            "회원정보가 즉시 삭제되며, 복구가 불가합니다."
        case .logout:
            ""
        }
    }
    
    var right: String {
        switch self {
        case .none:
            return ""
        case .deleteReview:
            return "삭제하기"
        case .reportReview:
            return "신고하기"
        case .revoke:
            return "회원탈퇴"
        case .logout:
            return Choice.yes.rawValue
        }
    }
    
    var left: String {
        switch self {
        case .none:
            return ""
        case .deleteReview:
            return Choice.close.rawValue
        case .reportReview:
            return Choice.close.rawValue
        case .revoke:
            return Choice.no.rawValue
        case .logout:
            return Choice.no.rawValue
        }
    }
}

enum SinglePopup {
    case none
    case failLogin
    case failSignIn
    case failLogout
    case failRevoke
    case successLogout
    case successRevoke
    case modifyReview
    case failModifyReview
    
    var title: String {
        switch self {
        case .none:
            return ""
        case .failLogin:
            return "로그인에 실패했어요"
        case .failSignIn:
            return "회원가입에 실패했어요"
        case .failLogout:
            return "로그아웃에 실패했어요"
        case .failRevoke:
            return "회원탈퇴에 실패했어요"
        case .modifyReview:
            return "수정이 완료되었어요!"
        case .successLogout:
            return "로그아웃이 완료되었습니다."
        case .successRevoke:
            return "회원 탈퇴가 완료되었습니다."
        case .failModifyReview:
            return "수정에 실패했어요"
        }
    }
    
    var button: String {
        switch self {
        case .none:
            return ""
        case .failLogin:
            return Choice.retry.rawValue
        case .failSignIn:
            return Choice.retry.rawValue
        case .failLogout:
            return Choice.retry.rawValue
        case .failRevoke:
            return Choice.retry.rawValue
        case .modifyReview:
            return Choice.check.rawValue
        case .successLogout:
            return Choice.check.rawValue
        case .successRevoke:
            return Choice.check.rawValue
        case .failModifyReview:
            return Choice.retry.rawValue
        }
    }
}

enum Choice: String {
    case check = "확인"
    case cancel = "취소"
    case no = "아니요"
    case yes = "네"
    case close = "닫기"
    case retry = "다시 시도해주세요"
    case remove = "삭제하기"
    case report = "신고하기"
}
enum Popup: CaseIterable {
    case reportReview
    case modifyReview
    case deleteReview
    case logout
    case revoke
    
    var title: String {
        switch self {
        case .reportReview:
           return "report"
        case .modifyReview:
            return "modifier"
        case .deleteReview:
            return "delete"
        case .logout:
            return "로그아웃에 실패했어요"
        case .revoke:
            return "회원탈퇴에 실패했어요"
        }
    }
    
    var left: String {
        switch self {
        case .reportReview:
            return "report"
        case .modifyReview:
            return "modifier"
        case .deleteReview:
            return "delete"
        case .logout:
            return "다시 시도해주세요"
        case .revoke:
            return "다시 시도 해주세요"
        }
    }
}
