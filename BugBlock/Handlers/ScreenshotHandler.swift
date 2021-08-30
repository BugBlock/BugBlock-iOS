//
//  ScreenshotHandler.swift
//  BugBlock
//
//  Created by Vadym Kozak on 26.08.2021.
//

import UIKit

protocol ScreenshotHandlerProtocol {
    func handleScreenshot()
}

class ScreenshotHandler: ScreenshotHandlerProtocol {
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
//        self.screenshotView.imageView?.image = image
    }
    
    private func presentVC(image: UIImage) {
        let vc = ScreenshotVC()
        vc.image = image
        guard let visibleVC = UIApplication.shared.windows.first?.visibleViewController else {
            return
        }
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        visibleVC.present(nc, animated: true, completion: nil)
    }
}
