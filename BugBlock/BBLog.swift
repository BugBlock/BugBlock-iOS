//
//  BugBlock.swift
//  BugBlock
//
//  Created by Vadym Kozak on 19.08.2021.
//

import Foundation

public class BBLog {
    private static var appId: String?
    static var logger: LoggerProtocol?
    
    public class func start(appId: String, configuration: BBConfiguration) {
        self.appId = appId
        self.logger = Logger(appId: appId, configuration: configuration)
        
    }
    
    public class func consoleLog(string: String, logLevel: ConsoleLogLevel = .info) {
        logger?.log(data: ConsoleData(timestamp: Date(), string: string, logLevel: logLevel))
    }
    
    public class func report() {
        logger?.report()
    }
    
    public class func networkLogging(with configuration: URLSessionConfiguration) {
        configuration.protocolClasses = [NetworkLogger.self]
    }
}

