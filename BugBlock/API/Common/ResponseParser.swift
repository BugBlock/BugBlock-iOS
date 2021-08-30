//
//  ResponseParser.swift
//  BugBlock
//
//  Created by Vadym Kozak on 21.07.2021.
//

import Foundation


enum ResponseParserError: Error {
    case data
}

class ResponseParser {
    private let data: Data?
    private let error: Error?
    private let response: HTTPURLResponse?
    private let decoder = JSONDecoder()
    
    init(response: URLResponse?, data: Data?, error: Error?) {
        self.response = response as? HTTPURLResponse
        self.data = data
        self.error = error
    }
    
    func parseVoid<E: Error & Codable>() throws -> VoidResult<E> {
        if let error = error {
            throw error
        }
        guard let data = data else {
            throw ResponseParserError.data
        }
        if 200..<299 ~= (response?.statusCode ?? 0) {
            return .success
        } else {
            let apiError = try decoder.decode(E.self, from: data)
            return .failure(apiError)
        }
    }
    
    func parse<T: Codable, E: Error & Codable>() throws -> Result<T, E> {
        if let error = error {
            throw error
        }
        guard let data = data else {
            throw ResponseParserError.data
        }
        if 200..<299 ~= (response?.statusCode ?? 0) {
            let parsedData = try decoder.decode(T.self, from: data)
            return .success(parsedData)
        } else {
            let apiError = try decoder.decode(E.self, from: data)
            return .failure(apiError)
        }
    }
    
    func parseArray<T: Codable, E: Error & Codable>() throws -> ArrayResult<T, E> {
        if let error = error {
            throw error
        }
        guard let data = data else {
            throw ResponseParserError.data
        }
        if 200..<299 ~= (response?.statusCode ?? 0) {
            let parsedData = try decoder.decode([T].self, from: data)
            return .success(parsedData)
        } else {
            let apiError = try decoder.decode(E.self, from: data)
            return .failure(apiError)
        }
    }
}
