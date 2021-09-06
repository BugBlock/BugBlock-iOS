//
//  ScreenshotView.swift
//  BugBlock
//
//  Created by Vadym Kozak on 14.08.2021.
//

import UIKit

protocol ScreenshotViewDelegate: AnyObject {
    func canUndo(can: Bool)
    func canRedo(can: Bool)
}

class ScreenshotView: UIView {
    private var prevPoint: CGPoint?
    private var path = UIBezierPath()
    private var line = CAShapeLayer()
    private var lines = [CAShapeLayer]() {
        didSet {
            self.delegate?.canUndo(can: canUndo())
        }
    }
    private var removedLines = [CAShapeLayer]() {
        didSet {
            self.delegate?.canRedo(can: canRedo())
        }
    }
    
    @IBOutlet var imageView: UIImageView?
    weak var delegate: ScreenshotViewDelegate?
    var selectedColor: UIColor = .systemRed
    
    override func draw(_ rect: CGRect) {
        path.lineWidth = 1
        UIColor.systemRed.setStroke()
        path.stroke()
    }
    
    override func didMoveToWindow() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(gesture(_:)))
        gesture.maximumNumberOfTouches = 1
        self.addGestureRecognizer(gesture)
        self.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    @objc private func gesture(_ gesture: UIPanGestureRecognizer) {
        let point = gesture.location(in: self)

        if let prevPoint = prevPoint {
            path.move(to: prevPoint)
            path.addLine(to: point)
            line.path = path.cgPath
            line.lineWidth = 2.0
            line.fillColor = UIColor.clear.cgColor
            line.strokeColor = selectedColor.cgColor
        }

        prevPoint = point
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = event?.allTouches?.first?.location(in: self)
        path = UIBezierPath()
        line = CAShapeLayer()
        imageView?.layer.addSublayer(line)
        lines.append(line)
        prevPoint = point
        removedLines.removeAll()
    }
    
    private func canUndo() -> Bool {
        return lines.count > 0
    }
    
    private func canRedo() -> Bool {
        return removedLines.count > 0
    }
    
    func undo() {
        if canUndo() {
            removedLines.append(lines.last!)
            lines.last?.removeFromSuperlayer()
            lines.removeLast()
        }
    }
    
    func redo() {
        if let line = removedLines.last {
            lines.append(line)
            imageView?.layer.addSublayer(line)
            removedLines.removeLast()
        }
    }
}
