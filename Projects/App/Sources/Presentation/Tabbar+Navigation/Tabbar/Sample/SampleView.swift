//
//  HomeView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
//            Color.red
//                .ignoresSafeArea()
            Text("GO TO ANOTHERVIEW")
//                .foregroundStyle(.white)
                .font(.largeTitle)
                .onTapGesture {
                    router.navigateTo(.categoryFilter)
                }
        }
    }
}

struct CategoryView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()
            Text("GO TO ANOTHERVIEW")
                .onTapGesture {
                    router.navigateTo(.productDetail)
                }
        }
    }
}

struct MypageView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            Text("GO TO PRODUCTDETAIL")
                .onTapGesture {
                    router.replaceNavigationStack(.productDetail)
                }
        }
    }
}

#Preview {
    HomeView()
}
