//
//  TabbarViewModel.swift
//  App
//
//  Created by 박서연 on 2024/06/13.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

final class TabbarViewModel: ObservableObject {
    @Published var selected: Tabbar = .home
}
