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
