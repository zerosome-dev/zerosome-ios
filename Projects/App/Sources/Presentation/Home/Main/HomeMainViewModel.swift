//
//  HomeMainViewModel.swift
//  App
//
//  Created by 박서연 on 2024/08/06.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import Combine

class HomeMainViewModel: ObservableObject {
    
    enum Action {
        case tobeReleased
        case cafe
    }
    
    @Published var tapData: Int = 0
    @Published var tobeReleased: [HomeRolloutResponseDTO] = []
    @Published var homeCafe: [HomeCafeResponseDTO] = []
    
    private let homeUsecase: HomeUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        homeUsecase: HomeUsecase
    ) {
        self.homeUsecase = homeUsecase
    }
    
    func send(action: Action) {
        switch action {
        case .tobeReleased:
            Task {
                await homeUsecase.tobeReleaseProduct()
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            debugPrint("🧪 \(error.localizedDescription)")
                        }
                    }, receiveValue: { data in
                        self.tobeReleased = data
                    })
                    .store(in: &cancellables)
            }
            
        case .cafe:
            Task {
                await homeUsecase.homeCafe()
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            debugPrint("🧪🧪 \(error.localizedDescription)")
                        }
                    }, receiveValue: { data in
                        self.homeCafe = data
                    })
                    .store(in: &cancellables)
            }
        }
    }
    
}
