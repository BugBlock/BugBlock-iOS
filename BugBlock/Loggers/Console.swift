//
//  Console.swift
//  BugBlock
//
//  Created by Vadym Kozak on 19.08.2021.
//

import Foundation

protocol LogConsoleProtocol {
    func printFormatted<T: Codable>(data: T)
}

class LogConsole: LogConsoleProtocol {
    func printFormatted<T: Codable>(data: T) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let encodedData = try! encoder.encode(data)
        //print(String(data: encodedData, encoding: .utf8)!)
    }
}
