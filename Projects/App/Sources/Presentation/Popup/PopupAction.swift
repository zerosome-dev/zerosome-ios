//
//  PopupAction.swift
//  App
//
//  Created by 박서연 on 2024/09/02.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

final class PopupAction: ObservableObject {
    
    @Published var singleToggle: SinglePopup = .none
    @Published var doubleToggle: DoublePopup = .none
    
    @Published var none: Bool = false
    @Published var deleteReview: Bool = false
    @Published var reportReview: Bool = false
    @Published var failLogin: Bool = false
    @Published var failSignIn: Bool = false
    @Published var failLogout: Bool = false
    @Published var failRevoke: Bool = false
    @Published var modifyReview: Bool = false
    @Published var rightButtonTapped: Bool = false

    func settingToggle(type: SinglePopup) {
        self.singleToggle = type
        print(self.singleToggle)
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
        }
    }
}
