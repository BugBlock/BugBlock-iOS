//
//  ScreenshotVC.swift
//  BugBlock
//
//  Created by Vadym Kozak on 26.08.2021.
//

import UIKit

class ScreenshotVC: UIViewController, ScreenshotViewDelegate {
    @IBOutlet weak var screenshotView: ScreenshotView!
    var image: UIImage?
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var paintButton: UIButton!
    @IBOutlet weak var redoButton: UIButton!
    @IBOutlet weak var addDesctiptionButton: UIButton!
    @IBOutlet weak var colors: UIStackView!
    @IBOutlet weak var actions: UIStackView!
    
    private let colorsArray: [UIColor] = [.systemRed, .systemOrange, .systemGreen, .systemBlue, .darkGray]
    private let reporter: BugReporterProtocol
    
    public init(reporter: BugReporterProtocol) {
        self.reporter = reporter
        super.init(nibName: "ScreenshotVC", bundle: Bundle(for: ScreenshotVC.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Report a bug"
        self.screenshotView.delegate = self
        self.screenshotView.imageView?.image = image
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
    }
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func canUndo(can: Bool) {
        undoButton.tintColor = can ? .systemBlue : .systemGray
    }

    func canRedo(can: Bool) {
        redoButton.tintColor = can ? .systemBlue : .systemGray
    }
    
    @IBAction func undo(_ sender: Any) {
        screenshotView.undo()
    }
    
    @IBAction func redo(_ sender: Any) {
        screenshotView.redo()
    }
    
    @IBAction func paint(_ sender: Any) {
        UIView.animate(withDuration: 0.1) {
            self.actions.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.colors.alpha = 1
            }
        }
    }
    
    @IBAction func selectColor(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            self.colors.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.actions.alpha = 1
            }
        }
        self.colors.subviews.compactMap({ $0 as? UIButton}).forEach({ $0.setImage(nil, for: .normal)})
        let image = UIImage(named: "check-mark")
        sender.setImage(image, for: .normal)
        screenshotView.selectedColor = colorsArray[sender.tag]
    }
    
    @IBAction func addDescription(_ sender: Any) {
        guard let size = self.screenshotView.imageView?.frame.size else {
            return
        }
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        self.screenshotView.imageView?.layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        let descriptionVC = DescriptionVC(reporter: reporter)
        descriptionVC.image = image
        self.navigationController?.pushViewController(descriptionVC, animated: true)
    }
}
