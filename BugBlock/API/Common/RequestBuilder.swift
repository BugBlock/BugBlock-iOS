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
    
    
    func build(with image: Data) throws -> URLRequest {
        guard let url = URL(string: url) else {
            throw RequestBuilderError.url
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = method
        
        let boundary = UUID().uuidString
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        let paramName = "image"
        let fileName = "image.png"
        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image)
        
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = data
        
        return request
    }
}
