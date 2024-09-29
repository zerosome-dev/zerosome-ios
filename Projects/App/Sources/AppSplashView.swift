//
//  ContentView.swift
//  App
//
//  Created by 박서연 on 2024/05/11.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct AppSplashView: View {
    var body: some View {
        ZStack {
            Color.primaryFF6972
                .ignoresSafeArea()
            
            ZerosomeAsset.splash_logo
                .resizable()
                .frame(width: 150, height: 150)
        }
    }
}

#Preview {
    AppSplashView()
}
