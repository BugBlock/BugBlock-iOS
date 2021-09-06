//
//  Metadata.swift
//  BugBlock
//
//  Created by Vadym Kozak on 25.08.2021.
//

import Foundation

struct Metadata: Codable {
    var osType: String?
    var osVersion: String?
    var appVersion: String?
    var appPackageName: String?
    var deviceName: String?
    var networkType: String?
    var userUUID: String?
    var userEmail: String?
    var userName: String?
}
