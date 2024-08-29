//
//  MypageRepository.swift
//  App
//
//  Created by 박서연 on 2024/08/30.
//  Copyright © 2024 iOS. All rights reserved.
//

import Combine

final class MypageRepository: MypageRepositoryProtocol {
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getUserBasicInfo() -> Future<MemberBasicInfoResult, NetworkError> {
        return Future { promise in
            Task {
                let response: Result<MemberBasicInfoResponseDTO, NetworkError> = await self.apiService.request(
                    httpMethod: .get,
                    endPoint: APIEndPoint.url(for: .userInfo),
                    header: AccountStorage.shared.accessToken
                )
                
                switch response {
                case .success(let success):
                    let mappedResult = MypageMapper.toMemberBasicInfo(response: success)
                    promise(.success(mappedResult))
                case .failure(let failure):
                    debugPrint("Mypage UserInfo failed \(failure.localizedDescription)")
                    promise(.failure(NetworkError.badRequest))
                }
            }
        }
    }
    
    func logout() -> Future<Bool, NetworkError> {
        return Future { promise in
            Task {
                let response: Result<NoneDecodeResponse, NetworkError> = await self.apiService.request(
                    httpMethod: .delete,
                    endPoint: APIEndPoint.url(for: .logout),
                    header: AccountStorage.shared.accessToken
                )
                
                switch response {
                case .success(let success):
                    promise(.success(true))
                case .failure(let failure):
                    debugPrint("Failure to Logout!! \(failure.localizedDescription)")
                    promise(.failure(NetworkError.badRequest))
                }
            }
        }
    }
    
    func revoke() -> Future<Bool, NetworkError> {
        return Future { promise in
            Task {
                let response: Result<NoneDecodeResponse, NetworkError> = await self.apiService.request(
                    httpMethod: .delete,
                    endPoint: APIEndPoint.url(for: .signIn),
                    header: AccountStorage.shared.accessToken
                )
                
                switch response {
                case .success(let success):
                    promise(.success(true))
                case .failure(let failure):
                    debugPrint("Failure to Revoke!! \(failure.localizedDescription)")
                    promise(.failure(NetworkError.badRequest))
                }
            }
        }
    }
}
