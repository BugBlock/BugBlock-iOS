//
//  BugData.swift
//  BugBlock
//
//  Created by Vadym Kozak on 25.08.2021.
//

import Foundation

struct BugData {
    var metadata: Metadata?
    var networkLogs: [NetworkData]?
    var consoleLogs: [ConsoleData]?
}
