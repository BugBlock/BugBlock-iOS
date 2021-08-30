//
//  ApiService.swift
//  BugBlock
//
//  Created by Vadym Kozak on 25.08.2021.
//

import Foundation

protocol ApiServiceProtocol {
    func report(crash: CrashData, completionHandler: @escaping (VoidResult<ApiError>) -> Void)
    func report(bug: BugData, completionHandler: @escaping (VoidResult<ApiError>) -> Void)
}

class ApiService: ApiServiceProtocol {
    func report(crash: CrashData, completionHandler: @escaping (VoidResult<ApiError>) -> Void) {
        completionHandler(.failure(ApiError(message: "test")))
    }
    
    func report(bug: BugData, completionHandler: @escaping (VoidResult<ApiError>) -> Void) {
        completionHandler(.failure(ApiError(message: "test")))
    }
}
