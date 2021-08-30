//
//  CrashReporter.swift
//  BugBlock
//
//  Created by Vadym Kozak on 25.08.2021.
//

import Foundation

protocol CrashReporterProtocol {
    init(apiService: ApiServiceProtocol?, crashLogger: CrashLoggerProtocol)
    var delegate: CrashReporterDelegate? {get set}
    func registerHandler()
    
}

protocol CrashReporterDelegate {
    func crashReported()
}

class CrashReporter: CrashReporterProtocol {
    var delegate: CrashReporterDelegate?
    private var apiService: ApiServiceProtocol?
    private var crashLogger: CrashLoggerProtocol?
    
    required init(apiService: ApiServiceProtocol?, crashLogger: CrashLoggerProtocol) {
        self.apiService = apiService
        self.crashLogger = crashLogger
    }
    
    func registerHandler() {
        self.crashLogger?.handleCrashes(completion: { [weak self] crashes in
            self?.report(crashes: crashes)
        })
    }

    private func report(crashes: [String]?) {
        if let crash = crashes?.first {
            let data = CrashData(metadata: Metadata(), log: crash)
            apiService?.report(crash: data, completionHandler: { [weak self] error in
                self?.delegate?.crashReported()
            })
        }
    }
}
