//
//  ContentView.swift
//  App
//
//  Created by 박서연 on 2024/05/11.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct ContentView: View {
    var body: some View {
        RouterView {
            TabbarMainView()
        }
    }
}

#Preview {
    ContentView()
}
