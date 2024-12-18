//
//  TabbarRefactorView.swift
//  App
//
//  Created by 박서연 on 2024/11/13.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

class refactorTab: ObservableObject {
    @Published var testToggle: Bool = false
    @Published var onappearTest = "AAA"
    @Published var count = 0
}

struct TabbarRefactorView: View {    
    let apiService: ApiService
    @StateObject var viewModel = TabbarViewModel()
    @EnvironmentObject var popup: PopupAction
    @EnvironmentObject var toast: ToastAction
    
    init(apiService: ApiService) {
        self.apiService = apiService
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .clear
        
        let systemFontAttributes: [NSAttributedString.Key: Any] = [
            .font: ZSFont.body4.toUIFont
        ]
        
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = systemFontAttributes.merging(
            [.foregroundColor: UIColor.primaryFF6972UI]) { _, new in new }
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = systemFontAttributes.merging(
            [.foregroundColor: UIColor.neutral200UI]) { _, new in new }

        appearance.stackedLayoutAppearance.selected.iconColor = .primaryFF6972UI
        appearance.stackedLayoutAppearance.normal.iconColor = .neutral200UI

        let inset: CGFloat = 8
        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: inset)
        appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: inset)
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $viewModel.selected) {
            let homeRepoProtocol = HomeRepository(apiService: apiService)
            let homeUseCase = HomeUsecase(homeRepoProtocol: homeRepoProtocol)
            let filterRepo = FilterRepository(apiService: apiService)
            let filterUsecase = FilterUsecase(filterRepoProtocol: filterRepo)
            let homeVM = HomeMainViewModel(homeUsecase: homeUseCase, filterUsecase: filterUsecase)
            
            HomeMainView(viewModel: homeVM)
                .tabItem {
                    Image(uiImage: resizeImage(ZerosomeTab.ic_home, targetSize: CGSize(width: 24, height: 34))!)
                    ZSText("홈", fontType: .body4)
                }
                .tag(Tabbar.home)
            
            let categoryRepoProtocol = CategoryListRepository(apiService: apiService)
            let categoryUseCase = CategoryUsecase(categoryRepoProtocol: categoryRepoProtocol)
            let categoryVM = CategoryViewModel(categoryUseCase: categoryUseCase)
            CategoryMainView(viewModel: categoryVM)
                .tabItem {
                    Image(uiImage: resizeImage(ZerosomeTab.ic_category, targetSize: CGSize(width: 24, height: 34))!)
                    ZSText("카테고리", fontType: .body4)
                }
                .tag(Tabbar.category)
            
            let mypageRepo = MypageRepository(apiService: apiService)
            let mypageUsecase = MypageUsecase(mypageRepoProtocol: mypageRepo)
            let mypageVM = MypageViewModel(mypageUseCase: mypageUsecase)
            MypageMainView(viewModel: mypageVM)
                .tabItem {
                    Image(uiImage: resizeImage(ZerosomeTab.ic_mypage, targetSize: CGSize(width: 24, height: 34))!)
                    ZSText("마이 페이지", fontType: .body4)
                }
                .tag(Tabbar.mypage)
        }
    }
    
    func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        let ratio = min(widthRatio, heightRatio)
        
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        let yOffset = (targetSize.height - newSize.height)
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let newImage = renderer.image { context in
          context.cgContext.setFillColor(UIColor.clear.cgColor)
          context.cgContext.fill(CGRect(origin: .zero, size: targetSize))
          image.draw(in: CGRect(x: 0, y: yOffset, width: newSize.width, height: newSize.height))
        }
        return newImage
      }
}

extension UITabBarController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let shadowView = view.subviews.first(where: { $0.accessibilityIdentifier == "TabBarShadow" }) {
            shadowView.frame = tabBar.frame
        } else {
            let shadowView = UIView(frame: .zero)
            shadowView.frame = tabBar.frame
            shadowView.accessibilityIdentifier = "TabBarShadow"
            shadowView.backgroundColor = UIColor.white
            shadowView.layer.shadowColor = Color.black.cgColor
            shadowView.layer.shadowOffset = CGSize(width: 0.0, height: -2.0)
            shadowView.layer.shadowOpacity = 0.1
            shadowView.layer.shadowRadius = 8
            view.addSubview(shadowView)
            view.bringSubviewToFront(tabBar)
        }
    }
}

#Preview {
    TabbarRefactorView(apiService: ApiService())
}
