//
//  CategoryMain.swift
//  App
//
//  Created by 박서연 on 2024/06/06.
//  Copyright © 2024 iOS. All rights reserved.
//

import DesignSystem
import SwiftUI
import Combine
import Kingfisher

class CategoryViewModel: ObservableObject {
    @Published var isNutrients: Bool = false
    @Published var updateToggle: Bool = false
    @Published var update: Update = .latest
    
    @Published var category: String = "전체"
    @Published var zeroTag: [String] = []
    @Published var brand: [String] = []
    
    @Published var sheetToggle: CategoryDetail? = nil
    @Published var tapData: Int?
    
    // brand
    @Published var brandTest: [String] = []
    // 카테고리
    @Published var categoryList: [D1CategoryResult] = []
    
    // title tap > 전체 코드를 사용해서 넘어가는 경우를 위한 전체 코드
    @Published var entirCode: String = ""
    @Published var tapD2Category: D2CategoryResult?
    @Published var filteredTitle: String = ""
    
    enum Action {
        case getCategoryList
        case tapCategoryTitle(D1CategoryResult)
        case tapD2CategoryItem(D1CategoryResult)
    }
    
    private let categoryUseCase: CategoryUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        categoryUseCase: CategoryUsecase
    ) {
        self.categoryUseCase = categoryUseCase
    }
    
    
    
    func send(action: Action) {
        switch action {
        case .getCategoryList:
            Task {
                await categoryUseCase.getCategoryList()
                    .receive(on: DispatchQueue.main)
                    .sink { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let failure):
                            debugPrint("Failed action: CategoryList \(failure.localizedDescription)")
                        }
                    } receiveValue: { [weak self] data in
                        self?.categoryList = data
//                        self?.entireCodeData = data.flatMap { d1CategoryResult in
//                            d1CategoryResult.d2Category.filter { d2CategoryResult in
//                                !d2CategoryResult.noOptionYn
//                            }
//                        } // [D1CategoryResult]                        
                    }
                    .store(in: &cancellables)
            }
        case .tapCategoryTitle(let d1Category):
            self.filteredTitle = d1Category.d1CategoryName
            self.entirCode = d1Category.d2Category.filter { $0.d2CategoryName == "전체" }.map { $0.d2CategoryCode }.joined()
            
        case .tapD2CategoryItem(let d1Category):
            self.filteredTitle = d1Category.d1CategoryName
        }
    }
}

struct CategoryMainView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: CategoryViewModel
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.categoryList, id: \.id) { d1Category in
                CategoryGridComponentTest(
                    tapData: $viewModel.tapData,
                    tapD2Category: $viewModel.tapD2Category,
                    data: d1Category
                )
                // 화면 이동할 때 네비 타이틀(전체 카테고리 + 필터ID)
                .tapTitle { // 전체 필터로 이동
                    viewModel.send(action: .tapCategoryTitle(d1Category))
                    router.navigateTo(.categoryFilter(
                        viewModel.filteredTitle,
                        viewModel.entirCode,
                        "전체")
                    )
                }
                .tapItem { // 카테고리 아이템 탭했을 때
                    // 각 d2카테고리의 필터뷰로 이동
                    guard let tapD2Category = viewModel.tapD2Category else { return }
                    router.navigateTo(.categoryFilter(
                        viewModel.filteredTitle,
                        tapD2Category.d2CategoryCode,
                        tapD2Category.d2CategoryName)
                    )
                }
            }
        }
        .padding(.horizontal, 22)
        .ZSnavigationTitle("카테고리")
        .scrollIndicators(.hidden)
        .onAppear {
//            viewModel.send(action: .getCategoryList)
        }
    }
}

struct CategoryGridComponentTest: View {
    
    @State private var showAllItems: Bool = false
    @Binding public var tapData: Int?
    @Binding public var tapD2Category: D2CategoryResult?
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    var tapTitle: (() -> Void)?
    var tapItem: (() -> Void)?
    var data: D1CategoryResult
    
    var displayedData: [D2CategoryResult] {
        if showAllItems || data.d2Category.count <= 9 {
            return data.d2Category
        } else {
            return Array(data.d2Category.prefix(8))
        }
    }
    
    init(tapData: Binding<Int?>,
         tapD2Category: Binding<D2CategoryResult?>,
         data: D1CategoryResult,
         tapTitle: (() -> Void)? = nil,
         tapItem: (() -> Void)? = nil
    ) {
        self._tapData = tapData
        self._tapD2Category = tapD2Category
        self.data = data
        self.tapTitle = tapTitle
        self.tapItem = tapItem
    }
    
    var body: some View {
        VStack(spacing: 12 ){
            let size = (UIScreen.main.bounds.width - (17 * 3) - 44) / 4
            
            HStack {
                ZSText(data.d1CategoryName, fontType: .heading2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ZerosomeAsset.ic_arrow_after
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            .onTapGesture {
                print("tap title 범위 체킹!")
                tapTitle?()
            }
            
            VStack(spacing: 30) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(displayedData) { data in
                        if data.d2CategoryName == "전체" {
                            EmptyView()
                        } else {
                            SqureCompoment(
                                image: data.d2CategoryImage,
                                category: data.d2CategoryName,
                                size: size
                            )
                            .onTapGesture {
                                // 카테고리 코드
                                tapData = Int(data.d2CategoryCode)
                                tapD2Category = data
                                tapItem?()
                            }
                        }
                    }
                }
                
                if data.d2Category.count > 8 && !showAllItems {
                    Text("전체 보기")
                        .padding(.init(top: 6, leading: 10, bottom: 6, trailing: 10))
                        .background(Color.neutral50)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .padding(.top, 18)
                        .onTapGesture {
                            showAllItems = true
                        }
                }
                
                
            }
        }
    }
}

extension CategoryGridComponentTest {
    func tapTitle(_ titleAction: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.tapTitle = titleAction
        return copy
    }
    
    func tapItem(_ itemAction: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.tapItem = itemAction
        return copy
    }
}

struct SqureCompoment: View {
    let image: String
    let category: String
    let size: CGFloat
    
    var body: some View {
        VStack(spacing: 6) {
            KFImage(URL(string: image))
                .placeholder { progress in
                    Rectangle()
                        .fill(Color.neutral50)
                        .frame(width: size, height: size)
                        .overlay {
                            ProgressView().tint(Color.primaryFF6972)
                        }
                }
                .resizable()
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            ZSText(category, fontType: .body3)
        }
    }
}

#Preview {
    CategoryMainView(viewModel: CategoryViewModel(categoryUseCase: CategoryUsecase(categoryRepoProtocol: CategoryListRepository(apiService: ApiService()))))
}
