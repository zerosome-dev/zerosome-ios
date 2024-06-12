//
//  CustomPageView.swift
//  App
//
//  Created by 박서연 on 2024/06/06.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct PagingBannerView<Content: View>: View {
    let pageCount: Int
    let content: Content
    
    @State private var currentPage = 0
    
    init(pageCount: Int, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self.content = content()
    }
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tag(0...pageCount-1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .overlay(alignment: .bottom) {
                PageControl(numberOfPages: pageCount, currentPage: $currentPage)
                    .padding(.bottom, 20)
            }
        }
    }
}

struct PageControl: View {
    let numberOfPages: Int
    @Binding var currentPage: Int
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<numberOfPages) { page in
                Circle()
                    .fill(page == currentPage ? Color.blue : Color.gray)
                    .frame(width: 6, height: 6)
                    .onTapGesture {
                        currentPage = page
                    }
            }
        }
    }
}

struct CustomPageView: View {
    var body: some View {
        PagingBannerView(pageCount: 3) {
            ForEach(0..<3) { index in
                Rectangle()
                    .fill()
                    .overlay {
                        Text("Page\(index + 1)")
                            .foregroundStyle(Color.white)
                    }
            }
        }
        .frame(height: 200)
        .padding()
    }
}

#Preview {
    CustomPageView()
}
