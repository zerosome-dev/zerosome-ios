//
//  HomeCarouselView.swift
//  App
//
//  Created by 박서연 on 2024/07/15.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem
import Kingfisher

class CarouselViewModel: ObservableObject {
    @Published var width: CGFloat = 0
}

struct HomeCarouselView: View {
    @StateObject private var vm = CarouselViewModel()
    private let sampleList = ["출시예정", "온라인", "오프라인"]
    private let tagList = ["생수/음료","탄산음료"]
    
    var body: some View {
        VStack {
            CarouselSecondView(width: $vm.width,
                               data: ZeroDrinkSampleData.data,
                               edgeSpacing: 23.5,
                               contentSpacing: 14,
                               totalSpacing: 22,
                               contentHeight: 327) { value in
                Rectangle()
                    .fill(.white)
                    .overlay {
                        VStack {
                            Rectangle()
                                .fill(Color.neutral50)
                                .frame(height: 216)
                                .overlay {
                                    KFImage(URL(string: value.photo))
                                        .resizable()
                                        .scaledToFit()
                                }
                            
                            Spacer()
                            VStack(spacing: 6) {
                                HStack(spacing: 8) {
                                    ForEach(tagList, id: \.self) { tag in
                                        Text(tag)
                                            .applyFont(font: .label1)
                                            .foregroundStyle(Color.neutral500)
                                    }
                                }
                                
                                Text(value.name)
                                    .applyFont(font: .subtitle1)
                                    .foregroundStyle(.black)
                                    .padding(.bottom, 9)
                                
                                HStack(spacing: 6) {
                                    ForEach(sampleList, id: \.self) { tag in
                                        Text(tag)
                                            .applyFont(font: .label2)
                                            .foregroundStyle(Color.neutral700)
                                            .padding(.init(top: 3, leading: 6, bottom: 3, trailing: 6))
                                            .background(Color.neutral50)
                                    }
                                }
                            }
                            .padding(.bottom, 16)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: .black.opacity(0.1), radius: 10, y: 10)
            } lastContent: {
                launchImage()
                    .shadow(color: .black.opacity(0.1), radius: 10, y: 10)
                    .onTapGesture {
                        print("페이지 이동!!!!")
                    }
            }
           
        }
    }
    
    @ViewBuilder func launchImage() -> some View {
        ZerosomeAsset.card_launch_more
            .resizable()
            .frame(width: vm.width)
            .scaledToFill()
    }
}


struct TTView: View {
    private let sampleList = ["출시예정", "온라인", "오프라인"]
    private let tagList = ["생수/음료","탄산음료"]
    
    var body: some View {
        Rectangle()
            .fill(.white)
            .overlay {
                VStack {
                    Rectangle()
                        .fill(Color.neutral50)
                        .frame(height: 216)
                        .overlay {
                            KFImage(URL(string: ""))
                                .resizable()
                                .scaledToFit()
                        }
                    
                    Spacer()
                    VStack(spacing: 6) {
                        HStack(spacing: 8) {
                            ForEach(tagList, id: \.self) { tag in
                                Text(tag)
                                    .applyFont(font: .label1)
                                    .foregroundStyle(Color.neutral500)
                            }
                        }
                        
                        Text("name")
                            .applyFont(font: .subtitle1)
                            .foregroundStyle(.black)
                            .padding(.bottom, 9)
                        
                        HStack(spacing: 6) {
                            ForEach(sampleList, id: \.self) { tag in
                                Text(tag)
                                    .applyFont(font: .label2)
                                    .foregroundStyle(Color.neutral700)
                                    .padding(.init(top: 3, leading: 6, bottom: 3, trailing: 6))
                                    .background(Color.neutral50)
                            }
                        }
                    }
                    .padding(.bottom, 16)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .black.opacity(0.1), radius: 10, y: 10)
    }
}
#Preview {
    HomeCarouselView()
}
