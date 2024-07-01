//
//  HomeSubTitleView.swift
//  App
//
//  Created by 박서연 on 2024/06/06.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct HomeSubTitleView: View {
    var title: String
    var subTitle: String
    
    enum TitleType {
        case none
        case rightButton
        case ranking
    }
    
    let columns: [GridItem] = [.init(.flexible(), spacing: 10, alignment: .center)]
    var type: TitleType
    @State private var choice: Bool = false
    @State private var typeArray: [String] = []

    var body: some View {
        VStack {
            titleView
            
            if type == .ranking {
                rankingView
            }
        }
    }

    @ViewBuilder
    private var titleView: some View {
        VStack(spacing: 2) {
            HStack {
                Text(title)
                    .applyFont(font: .heading1)
                Spacer()
                if type == .rightButton || type == .ranking {
                    moreButton
                }
            }
            
            Text(subTitle)
                .applyFont(font: .body2)
                .foregroundStyle(Color.neutral500)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.bottom, type == .ranking ? 10 : 0)
    }
    
    @ViewBuilder
    private var moreButton: some View {
        HStack(spacing: 0) {
            Text("더보기")
            Image(systemName: "chevron.right")
        }
        .applyFont(font: .caption)
        .foregroundStyle(Color.neutral700)
    }
    
    @ViewBuilder
    private var rankingView: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: columns) {
                ForEach(ZeroDrinkSampleData.dirnkType, id: \.self) { index in
                    Text("\(index)")
                        .padding(.init(top: 6, leading: 12, bottom: 6, trailing: 12))
                        .applyFont(font: .label1)
                        .foregroundStyle(typeArray.contains(index) ? Color.white :  Color.neutral400)
                        .background(typeArray.contains(index) ? Color.primaryFF6972 : Color.neutral50)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .onTapGesture {
                            toggleSelection(of: index)
                        }
                }
            }
        }
        .animation(.easeOut, value: typeArray)
        .frame(height: 30)
    }
    
    private func toggleSelection(of index: String) {
        if let existingIndex = typeArray.firstIndex(of: index) {
            typeArray.remove(at: existingIndex)
        } else {
            typeArray.append(index)
        }
    }
}



#Preview {
    HomeSubTitleView(title: "제목입니다.", subTitle: "서브타이틀입니다.", type: .ranking)
}
