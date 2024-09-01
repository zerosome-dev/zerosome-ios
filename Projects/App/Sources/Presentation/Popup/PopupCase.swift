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
    
    var title: String {
        switch self {
        case .none:
            return ""
        case .deleteReview:
            return "리뷰를 삭제할까요?"
        case .reportReview:
            return "신고할까요?"
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
        }
    }
}

enum SinglePopup {
    case none
    case failLogin
    case failSignIn
    case failLogout
    case failRevoke
    case modifyReview
    
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
