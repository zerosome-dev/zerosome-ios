//
//  MypageInfoViewModel.swift
//  App
//
//  Created by 박서연 on 2024/09/05.
//  Copyright © 2024 iOS. All rights reserved.
//

import UIKit

class MypageInfoViewModel: ObservableObject {
    enum Action {
        case serviceURL(Service)
        case customURL(CustomCenter)
    }
    
    func send(_ action: Action) {
        switch action {
        case .serviceURL(let url):
            if let url = URL(string: url.url) {
                UIApplication.shared.open(url)
            }
        case .customURL(let url):
            if let url = URL(string: url.url) {
                UIApplication.shared.open(url)
            }
        }
    }
}
