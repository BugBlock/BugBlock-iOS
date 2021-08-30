//
//  Network.swift
//  BugBlock
//
//  Created by Vadym Kozak on 18.08.2021.
//

import Foundation

enum NetworkError: Error {
    case wrongRequest, wrongResponse
}

struct NetworkData: Codable {
    var timestamp = Date()
    var url: URL
    var method: String
    var statusCode: Int
    var request: NetworkRequest
    var response: NetworkResponse
    
    init(request: URLRequest, response: URLResponse?, data: Data?) throws {
        guard let url = request.url,
              let method = request.httpMethod else {
            throw NetworkError.wrongRequest
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.wrongResponse
        }
        
        self.url = url
        self.method = method
        self.statusCode = httpResponse.statusCode
        self.request = NetworkRequest(headers: request.allHTTPHeaderFields, body: request.bodyData())
        self.response = NetworkResponse(headers: httpResponse.allHeaderFields, body: data)
    }
}


struct NetworkRequest: Codable {
    var headers: [String: String]?
    var body: String?
    
    init(headers: [String: String]?, body: Data?) {
        self.headers = headers
        if let body = body {
            self.body = String(data: body, encoding: .utf8)
        }
    }
}

struct NetworkResponse: Codable {
    var headers: [String: String]?
    var body: String?
    
    init(headers: [AnyHashable : Any], body: Data?) {
        self.headers = headers as? [String: String]
        if let body = body {
            self.body = String(data: body, encoding: .utf8)
        } else {
            print("RESPONSE IS NULL")
        }
    }
}
