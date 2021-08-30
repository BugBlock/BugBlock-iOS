//
//  Crash.swift
//  BugBlock
//
//  Created by Vadym Kozak on 25.08.2021.
//

import Foundation

protocol CrashLoggerProtocol {
    init()
    func handleCrashes(completion: @escaping (Array<String>?) -> Void)
}


class CrashLogger: CrashLoggerProtocol {
    let installation = KSCrashInstallationConsole.sharedInstance()
    required init() {
        installation?.install()
        installation?.printAppleFormat = true
    }
    
    func handleCrashes(completion: @escaping (Array<String>?) -> Void) {
        installation?.sendAllReports(completion: { reports, sent, error in
            guard let reports = reports else {
                completion(nil)
                return
            }
            let formatted = reports.compactMap({ $0 as? String})
            completion(formatted)
        })
    }
}
