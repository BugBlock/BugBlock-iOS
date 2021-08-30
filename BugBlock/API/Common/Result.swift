//
//  Result.swift
//  BugBlock
//
//  Created by Vadym Kozak on 22.07.2021.
//

import Foundation

enum VoidResult<E: Error & Codable> {
    case success
    case failure(E)
}

enum Result<T: Codable, E: Error & Codable> {
    case success(T)
    case failure(E)
}

enum ArrayResult<T: Codable, E: Error & Codable> {
    case success([T])
    case failure(E)
}
