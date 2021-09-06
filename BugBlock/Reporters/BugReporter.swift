//
//  BugReporter.swift
//  BugBlock
//
//  Created by Vadym Kozak on 25.08.2021.
//

import Foundation


protocol BugReporterProtocol {
    init(apiService: ApiServiceProtocol?, storage: LogStorageProtocol?)
    var delegate: BugReporterDelegate? {get set}
    func report()
}

protocol BugReporterDelegate {
    func bugReported()
}

class BugReporter: BugReporterProtocol {
    var delegate: BugReporterDelegate?
    private var apiService: ApiServiceProtocol?
    private var storage: LogStorageProtocol?
    
    required init(apiService: ApiServiceProtocol?, storage: LogStorageProtocol?) {
        self.apiService = apiService
        self.storage = storage
    }
    
    func report() {
        let bugData = Issue(metadata: Metadata(), networkLogs: self.storage?.networkLog, consoleLogs: self.storage?.consoleLog)
        self.apiService?.report(issue: bugData, completionHandler: { [weak self] error in
            switch error {
            case let .success(issueResponse):
                print(issueResponse.data.id)
                self?.storage?.clean()
                self?.delegate?.bugReported()
            case let .failure(apiError):
                print(apiError)
            }
        })
    }
}
