//
//  Storage.swift
//  BugBlock
//
//  Created by Vadym Kozak on 19.08.2021.
//

import Foundation

protocol LogStorageProtocol {
    var consoleLog: Array<ConsoleData> {get}
    var networkLog: Array<NetworkData> {get}
    func append<T: Codable>(data: T)
    func clean()
}


class LogStorage: LogStorageProtocol {
    private(set) var consoleLog = Array<ConsoleData>()
    private(set) var networkLog = Array<NetworkData>()
    
    func append<T: Codable>(data: T) {
        if let data = data as? ConsoleData {
            consoleLog.append(data)
        } else if let data = data as? NetworkData {
            networkLog.append(data)
        }
    }
    
    func clean() {
        consoleLog.removeAll()
        networkLog.removeAll()
    }
}
