//
//  Metadata.swift
//  BugBlock
//
//  Created by Vadym Kozak on 25.08.2021.
//

import Foundation
import UIKit


enum UserDefaultsKeys: String {
    case
        userUUID = "BugBlock.userUUID",
        userEmail = "BugBlock.userEmail",
        userName = "BugBlock.userName"
}

struct Metadata: Codable {
    var osType: String = "iOS"
    var osVersion: String?
    var appVersion: String?
    var appBuild: String?
    var appPackageName: String?
    var deviceName: String?
    var networkType: String?
    var userUUID: String?
    var userEmail: String?
    var userName: String?
    
    enum CodingKeys: String, CodingKey {
        case osType = "os_type"
        case osVersion = "os_version"
        case appVersion = "app_version"
        case appBuild = "app_build"
        case appPackageName = "app_package_name"
        case deviceName = "device_name"
        case networkType = "network_type"
        case userUUID = "user_uuid"
        case userEmail = "user_email"
        case userName = "user_name"
    }
    
    
    init() {
        osVersion = UIDevice.current.systemVersion
        appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        appBuild = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as? String
        appPackageName = Bundle.main.bundleIdentifier
        deviceName = UIDevice.current.modelName
        networkType = UIDevice.getConnectionType()
        userUUID = UserDefaults.standard.string(forKey: UserDefaultsKeys.userUUID.rawValue)
        userEmail = UserDefaults.standard.string(forKey: UserDefaultsKeys.userEmail.rawValue)
        userName = UserDefaults.standard.string(forKey: UserDefaultsKeys.userName.rawValue)
    }
}
