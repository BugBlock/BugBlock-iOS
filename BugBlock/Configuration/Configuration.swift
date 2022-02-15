//
//  Configuration.swift
//  BugBlock
//
//  Created by Vadym Kozak on 25.08.2021.
//

import Foundation

public struct BBConfiguration {
    public init() {
        
    }
    public var serverLoggingEnabled: Bool = false
    public var consoleLoggingEnabled: Bool = false
    public var crashReportingEnabled: Bool = false
    public var invokeByScreenshot: Bool = false
    public var invokeByShake: Bool = false
    public var printNetworkRequests: Bool = false
}
