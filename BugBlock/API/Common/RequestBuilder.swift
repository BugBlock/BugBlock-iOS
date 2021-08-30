//
//  RequestBuilder.swift
//  BugBlock
//
//  Created by Vadym Kozak on 21.07.2021.
//

import Foundation


enum RequestBuilderError: Error {
    case url
}

class RequestBuilder<T: Codable> {
    private let url: String
    private let body: T?
    private let method: String
    private let encoder = JSONEncoder()
    
    init(url: String, body: T?, method: String = "GET") {
        self.url = url
        self.body = body
        self.method = method
    }
    
    func build() throws -> URLRequest {
        guard let url = URL(string: url) else {
            throw RequestBuilderError.url
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        if method == "POST" || method == "PUT" ||  method == "PATCH" {
            request.httpBody = try encoder.encode(body)
        }
        
        return request
    }
}
