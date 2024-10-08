//
//  PopupAction.swift
//  App
//
//  Created by 박서연 on 2024/09/02.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

enum ToastCase {
    case none
    case reportToast
    case modiftyNickname
    case deleteReview
    case failNickname
    
    var type: ToastType{
        switch self {
        case .none:
            return .success
        case .reportToast:
            return .success
        case .modiftyNickname:
            return .success
        case .deleteReview:
            return .success
        case .failNickname:
            return .warning
        }
    }
    
    var desc: String {
        switch self {
        case .none:
            return ""
        case .reportToast:
            return "신고 접수가 완료되었습니다."
        case .modiftyNickname:
            return "닉네임이 변경되었어요"
        case .deleteReview:
            return "리뷰가 삭제되었습니다."
        case .failNickname:
            return "다시 시도해주세요"
        }
    }
}

final class ToastAction: ObservableObject {
    
    @Published var toastToggle: ToastCase = .none
    
    @Published var noneToggle: Bool = false
    @Published var reportToastToggle: Bool = false
    @Published var modiftyNicknameToggle: Bool = false
    @Published var deleteReviewToggle: Bool = false
    @Published var failNickname: Bool = false
    
    func settingToggle(type: ToastCase) {
        self.toastToggle = type
    }
    
    func setToggle(for type: ToastCase, _ value: Bool) {
        switch type {
        case .none:
            self.noneToggle = value
        case .reportToast:
            self.reportToastToggle = value
        case .modiftyNickname:
            self.modiftyNicknameToggle = value
        case .deleteReview:
            self.deleteReviewToggle = value
        case .failNickname:
            self.failNickname = value
        }
    }
    
    func binding(for type: ToastCase) -> Binding<Bool> {
        switch type {
        case .none:
            return Binding(
                get: { self.noneToggle },
                set: { self.noneToggle = $0 }
            )
        case .reportToast:
            return Binding(
                get: { self.reportToastToggle },
                set: { self.reportToastToggle = $0 }
            )
        case .modiftyNickname:
            return Binding(
                get: { self.modiftyNicknameToggle },
                set: { self.modiftyNicknameToggle = $0 }
            )
        case .deleteReview:
            return Binding(
                get: { self.deleteReviewToggle },
                set: { self.deleteReviewToggle = $0 }
            )
        case .failNickname:
            return Binding(
                get: { self.failNickname },
                set: { self.failNickname = $0 }
            )
        }
    }
}

final class PopupAction: ObservableObject {
    
    @Published var singleToggle: SinglePopup = .none
    @Published var doubleToggle: DoublePopup = .none
    
    @Published var none: Bool = false
    @Published var revoke: Bool = false
    @Published var logout: Bool = false
    @Published var deleteReview: Bool = false
    @Published var reportReview: Bool = false
    @Published var failLogin: Bool = false
    @Published var failSignIn: Bool = false
    @Published var failLogout: Bool = false
    @Published var successLogout: Bool = false
    @Published var failRevoke: Bool = false
    @Published var successRevoke: Bool = false
    @Published var modifyReview: Bool = false
    @Published var failModifyReview:Bool = false
    @Published var rightButtonTapped: Bool = false
    @Published var rightButtonFlag: Bool = false

    func settingToggle(type: SinglePopup) {
        self.singleToggle = type
    }
    
    func settingToggle(type: DoublePopup) {
        self.doubleToggle = type
    }
    
    func binding(for type: DoublePopup) -> Binding<Bool> {
        switch type {
        case .none:
            return Binding(
                get: { self.none },
                set: { self.none = $0 }
            )
        case .deleteReview:
            return Binding(
                get: { self.deleteReview },
                set: { self.deleteReview = $0 }
            )
        case .reportReview:
            return Binding(
                get: { self.reportReview },
                set: { self.reportReview = $0 }
            )
        case .revoke:
            return Binding(
                get: { self.revoke },
                set: { self.revoke = $0 }
            )
        case .logout:
            return Binding(
                get: { self.logout },
                set: { self.logout = $0 }
            )
        }
    }
    
    func binding(for type: SinglePopup) -> Binding<Bool> {
        switch type {
        case .none:
            return Binding(
                get: { self.none },
                set: { self.none = $0 }
            )
        case .failLogin:
            return Binding(
                get: { self.failLogin },
                set: { self.failLogin = $0 }
            )
        case .failSignIn:
            return Binding(
                get: { self.failSignIn },
                set: { self.failSignIn = $0 }
            )
        case .failLogout:
            return Binding(
                get: { self.failLogout },
                set: { self.failLogout = $0 }
            )
        case .failRevoke:
            return Binding(
                get: { self.failRevoke },
                set: { self.failRevoke = $0 }
            )
        case .modifyReview:
            return Binding(
                get: { self.modifyReview },
                set: { self.modifyReview = $0 }
            )
        case .successLogout:
            return Binding(
                get: { self.successLogout },
                set: { self.successLogout = $0 }
            )
        case .successRevoke:
            return Binding(
                get: { self.successRevoke },
                set: { self.successRevoke = $0 }
            )
        case .failModifyReview:
            return Binding(
                get: { self.failModifyReview },
                set: { self.failModifyReview = $0 }
            )
        }
    }
    
    func setToggle(for type: DoublePopup, _ value: Bool) {
        switch type {
        case .none:
            self.none = value
        case .deleteReview:
            self.deleteReview = value
        case .reportReview:
            self.reportReview = value
        case .revoke:
            self.revoke = value
        case .logout:
            self.logout = value
        }
    }
    
    func setToggle(for type: SinglePopup, _ value: Bool) {
        switch type {
        case .none:
            self.none = value
        case .failLogin:
            self.failLogin = value
        case .failSignIn:
            self.failSignIn = value
        case .failLogout:
            self.failLogout = value
        case .failRevoke:
            self.failRevoke = value
        case .modifyReview:
            self.modifyReview = value
        case .successLogout:
            self.successLogout = value
        case .successRevoke:
            self.successRevoke = value
        case .failModifyReview:
            self.failModifyReview = value
        }
    }
}
