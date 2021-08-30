//
//  ScreenshotListener.swift
//  BugBlock
//
//  Created by Vadym Kozak on 26.08.2021.
//

import Foundation
import UIKit

protocol ScreenshotListenerProtocol {
    init(handler: ScreenshotHandlerProtocol)
    func startListen()
}
class ScreenshotListener: ScreenshotListenerProtocol {
    private var handler: ScreenshotHandlerProtocol
    
    required init(handler: ScreenshotHandlerProtocol) {
        self.handler = handler
    }
    
    func startListen() {
        NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: OperationQueue.main) { [weak self] notification in
            self?.handler.handleScreenshot()
        }
        
    }
}
