//
//  Logger.swift
//  BugBlock
//
//  Created by Vadym Kozak on 18.08.2021.
//

import Foundation

protocol LoggerProtocol {
    init(appId: String, configuration: BBConfiguration)
    func log<T: Codable>(data: T)
    func report()
}

public class Logger: LoggerProtocol {
    private var storage: LogStorageProtocol?
    private var console: LogConsoleProtocol?
    private var apiService: ApiServiceProtocol?
    private var crashLogger: CrashLoggerProtocol?
    private var crashReporter: CrashReporterProtocol?
    private var bugReporter: BugReporterProtocol?
    private var metadataReporter: MetadataReporterProtocol?
    
    private var listener: ScreenshotListenerProtocol?
    private var handler: ScreenshotHandler?
    private var appId: String?
    
    required init(appId: String, configuration: BBConfiguration) {
        self.appId = appId
        if configuration.consoleLoggingEnabled {
            self.console = LogConsole()
        }
        if configuration.serverLoggingEnabled {
            self.storage = LogStorage()
            self.apiService = ApiService(appId: appId)
        }
        if configuration.crashReportingEnabled {
            self.crashLogger = CrashLogger()
            let crashReporter = CrashReporter(apiService: apiService, crashLogger: crashLogger!)
            crashReporter.delegate = self
            crashReporter.registerHandler()
        }
        self.bugReporter = BugReporter(apiService: apiService, storage: storage)
        self.metadataReporter = MetadataReporter(apiService: apiService)
        
        self.handler = ScreenshotHandler(reporter: bugReporter!)
        self.listener = ScreenshotListener(handler: handler!)
        self.listener?.startListen()
        
        self.metadataReporter?.report()
    }
    
    func log<T: Codable>(data: T) {
        storage?.append(data: data)
        console?.printFormatted(data: data)
    }
    
    func report() {
        self.bugReporter?.delegate = self
//        self.bugReporter?.report()
    }
}

extension Logger: CrashReporterDelegate {
    func crashReported() {
        print("Crash reported")
    }
}


extension Logger: BugReporterDelegate {
    func bugReported() {
        print("Bug reported")
    }
}

