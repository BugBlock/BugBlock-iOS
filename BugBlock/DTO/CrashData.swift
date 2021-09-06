//
//  CrashData.swift
//  BugBlock
//
//  Created by Vadym Kozak on 25.08.2021.
//

import Foundation

struct CrashData: Codable {
    var metadata: Metadata?
    var log: String?
}
