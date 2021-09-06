//
//  DataTask.swift
//  BugBlock
//
//  Created by Vadym Kozak on 21.07.2021.
//

import Foundation


extension URLSession {
    func dataTask<E: Error & Codable>(with request: URLRequest, completionHandler: @escaping (VoidResult<E>) -> Void) -> URLSessionDataTask {
        return dataTask(with: request) { data, response, error in
            let parser = ResponseParser(response: response, data: data, error: error)
            do {
                completionHandler(try parser.parseVoid())
            } catch {
                completionHandler(.failure(ApiError(error: error.localizedDescription) as! E))
            }
        }
    }
    
    func dataTask<T: Codable, E: Error & Codable>(with request: URLRequest, completionHandler: @escaping (Result<T, E>) -> Void) -> URLSessionDataTask {
        return dataTask(with: request) { data, response, error in
            let parser = ResponseParser(response: response, data: data, error: error)
            do {
                completionHandler(try parser.parse())
            } catch {
                completionHandler(.failure(ApiError(error: error.localizedDescription) as! E))
            }
        }
    }
    
    func dataTask<T: Codable, E: Error & Codable>(with request: URLRequest, completionHandler: @escaping (ArrayResult<T, E>) -> Void) -> URLSessionDataTask {
        return dataTask(with: request) { data, response, error in
            let parser = ResponseParser(response: response, data: data, error: error)
            do {
                completionHandler(try parser.parseArray())
            } catch {
                completionHandler(.failure(ApiError(error: error.localizedDescription) as! E))
            }
        }
    }
}
