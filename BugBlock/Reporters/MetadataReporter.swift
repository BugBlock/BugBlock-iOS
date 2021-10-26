//
//  MetadataReporter.swift
//  BugBlock
//
//  Created by Vadym Kozak on 26.10.2021.
//

import Foundation

protocol MetadataReporterProtocol {
    init(apiService: ApiServiceProtocol?)
//    var delegate: CrashReporterDelegate? {get set}
    func report()
    
}

//protocol CrashReporterDelegate {
//    func crashReported()
//}

class MetadataReporter: MetadataReporterProtocol {
//    var delegate: CrashReporterDelegate?
    private var apiService: ApiServiceProtocol?
    
    required init(apiService: ApiServiceProtocol?) {
        self.apiService = apiService
    }
    
    func report() {
        self.apiService?.report(metadata: MetadataData(metadata: Metadata()), completionHandler: {  result in
            switch result {
            case .success:
                print("Metadata added")
            case let .failure(apiError):
                print(apiError)
            }
        })
    }
}
