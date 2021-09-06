//
//  BugData.swift
//  BugBlock
//
//  Created by Vadym Kozak on 25.08.2021.
//

import Foundation

struct Issue: Codable {
    var email: String = ""
    var type: String = "bug"
    var description: String = ""
    var metadata: Metadata?
    var networkLogs: [NetworkData]?
    var consoleLogs: [ConsoleData]?
    
    enum CodingKeys: String, CodingKey {
        case email
        case type
        case description
        case metadata
        case networkLogs = "network_logs"
        case consoleLogs = "console_logs"
    }
}

struct IssueResponse: Codable {
    var data: IssueData
    
    
    struct IssueData: Codable {
        var id: Int = 0
        enum CodingKeys: String, CodingKey {
            case id = "id"
        }
    }
}
