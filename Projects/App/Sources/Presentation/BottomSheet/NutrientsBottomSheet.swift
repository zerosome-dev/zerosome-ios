//
//  NutrientsBottomSheet.swift
//  App
//
//  Created by 박서연 on 2024/07/04.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

class NutrientsViewModel: ObservableObject {
    enum Action {
        case getcriterion
    }
    
    @Published var criterion: NutrientByPdtResult?
    @Published var nutrientList: [NutrientByPdtResult]?
    @Published var filiteredNutrientList: [NutrientByPdtResult]?
    
    func send(_ action: Action) {
        switch action {
        case .getcriterion:
            guard let nutrientList = self.nutrientList else { return }
            criterion = nutrientList.first { $0.nutrientName == "기준 용량" }
            
            self.filiteredNutrientList = nutrientList.filter { $0.nutrientName != "기준 용량" }
        }
    }
}

public struct NutrientsBottomSheet: View {
    
    @ObservedObject var viewModel: DetailMainViewModel
    @StateObject var nutrientsModel = NutrientsViewModel()
    
    public var body: some View {
        VStack(spacing: 0) {
            CommonTitle(
                title: "제품 영양 정보",
                type: .image,
                imageTitle: ZerosomeAsset.ic_xmark
            )
            .imageAction { viewModel.isNutrients = false }
            .padding(.vertical, 24)
            
            if let nutrientList = nutrientsModel.filiteredNutrientList,
               let criterion = nutrientsModel.criterion {
                VStack(spacing: 6) {
                    HStack {
                        ZSText(
                            "\(criterion.amount)\(criterion.amountUnit)당",
                            fontType: .body2, color: .neutral600
                        )
                        
                        Spacer()
                        ZSText(
                            "\(criterion.percentage)\(criterion.percentageUnit)",
                            fontType: .body2, color: .neutral600
                        )
                    }
                    .padding(14)
                    .background(Color.neutral50)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    ScrollView {
                        ForEach(nutrientList, id: \.id) { data in
                            HStack{
                                ZSText(data.nutrientName, fontType: .body2, color: Color.neutral600)
                                Spacer()
                                ZSText(
                                    "\(data.amount)\(data.amountUnit)(\(data.percentage)\(data.percentageUnit))",
                                    fontType: .body2,
                                    color: Color.neutral600
                                )
                            }
                            .padding(.vertical, 14)
                            
                            Rectangle()
                                .fill(Color.neutral100)
                                .frame(maxWidth: .infinity, maxHeight: 1)
                                .opacity((data == nutrientList.last) ? 0 : 1)
                        }

                    }
                    .scrollIndicators(.hidden)
                }
            } else {
                VStack {
                    ProgressView()
                        .tint(.primaryFF6972)
                        .frame(width: 30, height: 30)
                    ZSText("준비중입니다", fontType: .subtitle1)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                Spacer()
            }
        }
        .onAppear {
            guard let data = viewModel.dataInfo?.nutrientList else { return }
            nutrientsModel.nutrientList = data
            nutrientsModel.send(.getcriterion)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    NutrientsBottomSheet(viewModel: DetailMainViewModel(
        detailUseCase: DetailUsecase(
            detailRepoProtocol: DetailRepository(
                apiService: ApiService()
            )
        )
    ))
}
