//
//  ScreenshotHandler.swift
//  BugBlock
//
//  Created by Vadym Kozak on 26.08.2021.
//

import UIKit

protocol ScreenshotHandlerProtocol {
    init(reporter: BugReporterProtocol)
    func handleScreenshot()
}

class ScreenshotHandler: ScreenshotHandlerProtocol {
    private let reporter: BugReporterProtocol
    
    required init(reporter: BugReporterProtocol) {
        self.reporter = reporter
    }
    
    func handleScreenshot() {
        guard let vc = UIApplication.shared.windows.first?.visibleViewController else {
            return
        }
        UIGraphicsBeginImageContextWithOptions(vc.view.frame.size, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        vc.view.layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        presentVC(image: image)
    }
    
    private func presentVC(image: UIImage) {
        let vc = ScreenshotVC(reporter: reporter)
        vc.image = image
        guard let visibleVC = UIApplication.shared.windows.first?.visibleViewController else {
            return
        }
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        visibleVC.present(nc, animated: true, completion: nil)
    }
}
