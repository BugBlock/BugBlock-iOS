//
//  BugReporter.swift
//  BugBlock
//
//  Created by Vadym Kozak on 25.08.2021.
//

import Foundation
import UIKit

protocol BugReporterProtocol {
    init(apiService: ApiServiceProtocol?, storage: LogStorageProtocol?)
    var delegate: BugReporterDelegate? {get set}
    func report(email: String, description: String, image: UIImage?)
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
    
    func report(email: String, description: String, image: UIImage?) {
        var bugData = Issue(metadata: Metadata(), networkLogs: self.storage?.networkLog, consoleLogs: self.storage?.consoleLog)
        bugData.email = email
        bugData.description = description
        self.apiService?.report(issue: bugData, completionHandler: { [weak self] result in
            switch result {
            case let .success(issueResponse):
                print(issueResponse.id)
                self?.storage?.clean()
                if let image = image {
                    self?.uploadImage(issueId: issueResponse.id, image: image)
                } else {
                    self?.delegate?.bugReported()
                }
            case let .failure(apiError):
                print(apiError)
            }
        })
    }
    
    private func uploadImage(issueId: Int, image: UIImage) {
        self.apiService?.image(issueId: issueId, image: image.pngData()!, completionHandler: { [weak self] result in
            print(result)
            self?.delegate?.bugReported()
        })
    }
}
