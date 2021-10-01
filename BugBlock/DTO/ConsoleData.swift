//
//  Console.swift
//  BugBlock
//
//  Created by Vadym Kozak on 19.08.2021.
//

import Foundation

public enum ConsoleLogLevel: String, Codable {
    case debug, info, warning, error
}

struct ConsoleData: Codable {
    var timestamp = Date()
    var string: String?
    var logLevel: ConsoleLogLevel = .info
    
    enum CodingKeys: String, CodingKey {
        case timestamp = "timestamp"
        case string = "string"
        case logLevel = "log_level"
    }
}
