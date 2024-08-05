//
//  HomeMainViewModel.swift
//  App
//
//  Created by 박서연 on 2024/08/06.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

class HomeMainViewModel: ObservableObject {
    
    enum Action {
        case tobeReleased
        case cafe
    }
    
    @Published var bannerResult: Bool = false
    @Published var tapData: String = ""
    @Published var tobeReleased: [HomeRolloutResponseDTO] = []
    @Published var homeCafe: [HomeCafeResponseDTO] = []
    private let homeUsecase: HomeUsecase
    
    init(homeUsecase: HomeUsecase) {
        self.homeUsecase = homeUsecase
    }
    
    func send(action: Action) {
        switch action {
        case .tobeReleased:
            Task {
                let result = await homeUsecase.tobeReleaseProduct()
                switch result {
                case .success(let success):
                    self.tobeReleased = success
                case .failure(let failure):
                    debugPrint("🧪 신상품 실패 \(failure.localizedDescription)")
                }
            }
            
        case .cafe:
            Task {
                let result = await homeUsecase.homeCafe()
                
                switch result {
                case .success(let success):
                    self.homeCafe = success
                case .failure(let failure):
                    debugPrint("🧪 홈카페 실패 \(failure.localizedDescription)")
                }
            }
        }
    }
    
}
