//
//  ApiError.swift
//  BugBlock
//
//  Created by Vadym Kozak on 22.07.2021.
//

import Foundation

struct ApiError: Error, Codable {
    let message: String?
}
