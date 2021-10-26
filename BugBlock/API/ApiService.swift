//
//  ApiService.swift
//  BugBlock
//
//  Created by Vadym Kozak on 25.08.2021.
//

import Foundation

protocol ApiServiceProtocol {
    init(appId: String)
    func report(crash: CrashData, completionHandler: @escaping (Result<IssueResponse, ApiError>) -> Void)
    func report(issue: Issue, completionHandler: @escaping (Result<IssueResponse, ApiError>) -> Void)
    func report(metadata: MetadataData, completionHandler: @escaping (VoidResult<ApiError>) -> Void)
    func image(issueId: Int, image: Data, completionHandler: @escaping (VoidResult<ApiError>) -> Void)
}

class ApiService: ApiServiceProtocol {
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    private let appId: String
    
    required init(appId: String) {
        self.appId = appId
    }
    
    func report(crash: CrashData, completionHandler: @escaping (Result<IssueResponse, ApiError>) -> Void) {
        let builder = RequestBuilder(appId: appId, url: "https://api.bugblock.io/reporter/crash", body: crash, method: "POST")
        do {
            let request = try builder.build()
            let task = session.dataTask(with: request, completionHandler: completionHandler)
            task.resume()
        } catch {
            completionHandler(.failure(ApiError(error: "request not valid")))
        }
    }
    
    func report(issue: Issue, completionHandler: @escaping (Result<IssueResponse, ApiError>) -> Void) {
        let builder = RequestBuilder(appId: appId, url: "https://api.bugblock.io/reporter/issue", body: issue, method: "POST")
        do {
            let request = try builder.build()
            print(String(data: request.httpBody!, encoding: .utf8)!)
            let task = session.dataTask(with: request, completionHandler: completionHandler)
            task.resume()
        } catch {
            completionHandler(.failure(ApiError(error: "request not valid")))
        }
    }
    
    func report(metadata: MetadataData, completionHandler: @escaping (VoidResult<ApiError>) -> Void) {
        
        let builder = RequestBuilder(appId: appId, url: "https://api.bugblock.io/reporter/metadata", body: metadata, method: "POST")
        do {
            let request = try builder.build()
            let task = session.dataTask(with: request, completionHandler: completionHandler)
            task.resume()
        } catch {
            completionHandler(.failure(ApiError(error: "request not valid")))
        }
    }
    
    func image(issueId: Int, image: Data, completionHandler: @escaping (VoidResult<ApiError>) -> Void) {
        let builder = RequestBuilder<ApiError>(appId: appId, url: "https://api.bugblock.io/reporter/issue/\(issueId)/image", body: nil, method: "PUT")
        do {
            let request = try builder.build(with: image)
            let task = session.dataTask(with: request, completionHandler: completionHandler)
            task.resume()
        } catch {
            completionHandler(.failure(ApiError(error: "request not valid")))
        }
    }
}
